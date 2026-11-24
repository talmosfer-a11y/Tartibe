import { Header } from "@/components/header";

export default function NewTripPage() {
  return (
    <main className="shell">
      <Header />
      <section className="page-head"><div className="eyebrow">خطوتك الأولى</div><h1>خطّط رحلة جديدة</h1><p className="lead">هذه واجهة إدخال أولية. ربط الحفظ وتوليد الخطة سيأتي بعد إعداد Supabase والخادم.</p></section>
      <section className="panel">
        <div className="field"><label htmlFor="destination">الوجهة أو الدولة</label><input id="destination" placeholder="مثال: اليابان" /></div>
        <div className="field"><label htmlFor="days">مدة الرحلة بالأيام</label><input id="days" type="number" min="1" placeholder="7" /></div>
        <div className="field"><label htmlFor="budget">الميزانية بالريال السعودي</label><input id="budget" type="number" min="0" placeholder="7000" /></div>
        <p className="note">النموذج بصري حاليًا ولا يحفظ البيانات بعد. لا تدخل معلومات حساسة.</p>
        <button className="btn btn-primary" disabled>إنشاء الخطة — قيد الربط</button>
      </section>
    </main>
  );
}
