import Link from "next/link";

export function Header() {
  return (
    <header className="topbar">
      <Link className="brand" href="/">
        <span className="brand-mark">ت</span>
        <span>ترتّب</span>
      </Link>
      <nav className="navlinks" aria-label="التنقل الرئيسي">
        <Link href="/#features">المميزات</Link>
        <Link href="/trips">رحلاتي</Link>
        <Link href="/trips/new">خطط رحلة</Link>
      </nav>
      <Link className="btn btn-secondary" href="/login">تسجيل الدخول</Link>
    </header>
  );
}
