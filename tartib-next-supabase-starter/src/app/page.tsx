import Link from "next/link";
import { Header } from "@/components/header";

export default function HomePage() {
  return (
    <main className="shell">
      <Header />
      <section className="hero">
        <div>
          <div className="eyebrow">رحلتك تبدأ بفكرة</div>
          <h1>خلّ التخطيط علينا،<br />واستمتع بالطريق.</h1>
          <p className="lead">
            ترتّب يساعدك تجمع تفاصيل رحلتك في مكان واحد؛ من الوجهة والميزانية
            إلى المدن والأنشطة وخطة الأيام. ابدأ بخطتك، وعدّلها متى ما احتجت.
          </p>
          <div className="actions">
            <Link className="btn btn-primary" href="/trips/new">ابدأ تخطيط رحلة</Link>
            <Link className="btn btn-secondary" href="/trips">استعرض رحلاتي</Link>
          </div>
        </div>
        <div className="hero-art" aria-label="بطاقة تخطيط رحلة">
          <span className="art-label">مساحة رحلتك القادمة</span>
          <div className="route-card">
            <div className="route-title">رحلة على مزاجك</div>
            <div className="route-sub">وجهة • ميزانية • أيام • تجارب</div>
            <div className="route-line"><span className="dot" /> اختر وجهتك <span className="dash" /> <span className="dot" /> عِش التجربة</div>
          </div>
        </div>
      </section>
      <section className="section" id="features">
        <h2>كل تفاصيل الرحلة في مكان واحد</h2>
        <p className="section-intro">هذه هي النواة الأولى، وسنضيف التكاملات الحقيقية على مراحل.</p>
        <div className="feature-grid">
          <article className="feature"><div className="feature-icon">⌖</div><h3>خطة واضحة</h3><p>رتّب المدن والأيام والأنشطة ضمن مسار مفهوم وقابل للتعديل.</p></article>
          <article className="feature"><div className="feature-icon">ر.س</div><h3>ميزانية محسوبة</h3><p>اجمع تقديرات الطيران والسكن والتنقل والأنشطة في نظرة واحدة.</p></article>
          <article className="feature"><div className="feature-icon">♡</div><h3>رحلات محفوظة</h3><p>احفظ خططك في حسابك وارجع لها من أي جهاز بعد تسجيل الدخول.</p></article>
        </div>
      </section>
      <footer className="footer">ترتّب — نسخة تأسيسية قيد التطوير</footer>
    </main>
  );
}
