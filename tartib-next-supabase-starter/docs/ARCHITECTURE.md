# البنية التقنية

- **Next.js App Router**: الواجهة ومسارات الخادم.
- **Supabase Auth**: حسابات المستخدمين والجلسات.
- **Supabase Postgres**: بيانات الرحلات.
- **RLS**: عزل بيانات كل مستخدم على مستوى قاعدة البيانات.
- **Gemini**: يضاف لاحقًا عبر Route Handler أو Server Action فقط؛ المفتاح يبقى خادميًا.
- **Vercel**: الاستضافة والنشر من GitHub.

لا تستخدم `service_role` في المتصفح. مفتاح anon/publishable وحده لا يمنح تجاوزًا لسياسات RLS.
