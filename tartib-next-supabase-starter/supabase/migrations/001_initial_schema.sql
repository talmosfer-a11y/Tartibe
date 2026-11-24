-- ترتّب: قاعدة البيانات التأسيسية
-- نفّذ هذا الملف في Supabase SQL Editor بعد مراجعة المشروع.
-- RLS مفعّل؛ لا تستخدم service_role في المتصفح.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  username text unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.trips (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  destination text,
  start_date date,
  end_date date,
  duration_days integer check (duration_days is null or duration_days > 0),
  budget_sar numeric(12,2) check (budget_sar is null or budget_sar >= 0),
  currency text not null default 'SAR',
  status text not null default 'draft' check (status in ('draft','planned','completed','archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.trip_cities (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips(id) on delete cascade,
  name text not null,
  country text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.trip_days (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips(id) on delete cascade,
  city_id uuid references public.trip_cities(id) on delete set null,
  day_number integer not null check (day_number > 0),
  trip_date date,
  title text,
  notes text,
  created_at timestamptz not null default now(),
  unique (trip_id, day_number)
);

create table if not exists public.activities (
  id uuid primary key default gen_random_uuid(),
  trip_day_id uuid not null references public.trip_days(id) on delete cascade,
  title text not null,
  description text,
  place_name text,
  start_time time,
  end_time time,
  estimated_cost_sar numeric(12,2) check (estimated_cost_sar is null or estimated_cost_sar >= 0),
  source_url text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.trip_flights (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips(id) on delete cascade,
  airline text,
  flight_number text,
  departure_airport text,
  arrival_airport text,
  departure_at timestamptz,
  arrival_at timestamptz,
  price_sar numeric(12,2),
  source_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.trip_stays (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips(id) on delete cascade,
  name text not null,
  city text,
  check_in date,
  check_out date,
  price_sar numeric(12,2),
  source_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.trip_preferences (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null unique references public.trips(id) on delete cascade,
  interests text[] not null default '{}',
  travel_style text,
  pace text,
  notes text,
  created_at timestamptz not null default now()
);

create index if not exists trips_user_id_idx on public.trips(user_id);
create index if not exists trip_cities_trip_id_idx on public.trip_cities(trip_id);
create index if not exists trip_days_trip_id_idx on public.trip_days(trip_id);
create index if not exists activities_trip_day_id_idx on public.activities(trip_day_id);

alter table public.profiles enable row level security;
alter table public.trips enable row level security;
alter table public.trip_cities enable row level security;
alter table public.trip_days enable row level security;
alter table public.activities enable row level security;
alter table public.trip_flights enable row level security;
alter table public.trip_stays enable row level security;
alter table public.trip_preferences enable row level security;

drop policy if exists "profile owner can read" on public.profiles;
create policy "profile owner can read" on public.profiles
for select to authenticated using (auth.uid() = id);

drop policy if exists "profile owner can insert" on public.profiles;
create policy "profile owner can insert" on public.profiles
for insert to authenticated with check (auth.uid() = id);

drop policy if exists "profile owner can update" on public.profiles;
create policy "profile owner can update" on public.profiles
for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "owners manage trips" on public.trips;
create policy "owners manage trips" on public.trips
for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Child rows are accessible only when their parent trip belongs to the signed-in user.
drop policy if exists "owners manage trip cities" on public.trip_cities;
create policy "owners manage trip cities" on public.trip_cities
for all to authenticated using (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
) with check (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
);

drop policy if exists "owners manage trip days" on public.trip_days;
create policy "owners manage trip days" on public.trip_days
for all to authenticated using (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
) with check (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
);

drop policy if exists "owners manage activities" on public.activities;
create policy "owners manage activities" on public.activities
for all to authenticated using (
  exists (
    select 1 from public.trip_days d
    join public.trips t on t.id = d.trip_id
    where d.id = trip_day_id and t.user_id = auth.uid()
  )
) with check (
  exists (
    select 1 from public.trip_days d
    join public.trips t on t.id = d.trip_id
    where d.id = trip_day_id and t.user_id = auth.uid()
  )
);

drop policy if exists "owners manage trip flights" on public.trip_flights;
create policy "owners manage trip flights" on public.trip_flights
for all to authenticated using (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
) with check (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
);

drop policy if exists "owners manage trip stays" on public.trip_stays;
create policy "owners manage trip stays" on public.trip_stays
for all to authenticated using (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
) with check (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
);

drop policy if exists "owners manage trip preferences" on public.trip_preferences;
create policy "owners manage trip preferences" on public.trip_preferences
for all to authenticated using (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
) with check (
  exists (select 1 from public.trips t where t.id = trip_id and t.user_id = auth.uid())
);
