import Link from "next/link";
import { Header } from "@/components/header";

export default function TripsPage() {
  return (
    <main className="shell">
      <Header />
      <section className="page-head"><div className="eyebrow">مساحة رحلاتك</div><h1>رحلاتي</h1><p className="lead">ستظهر هنا الرحلات المحفوظة في حسابك بعد إكمال تسجيل الدخول وربط قاعدة البيانات.</p></section>
      <section className="panel">
        <h2>ما عندك رحلات محفوظة حتى الآن</h2>
        <p className="note">ابدأ بإنشاء خطة جديدة. الحفظ السحابي سيُفعّل في المرحلة التالية.</p>
        <Link className="btn btn-primary" href="/trips/new">إنشاء رحلة</Link>
      </section>
    </main>
  );
}
