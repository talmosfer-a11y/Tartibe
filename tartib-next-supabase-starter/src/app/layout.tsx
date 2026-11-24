import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "ترتّب | خطّط رحلتك بذكاء",
  description: "منصة عربية تساعدك على تخطيط رحلتك وحفظ تفاصيلها في مكان واحد.",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="ar" dir="rtl">
      <body>{children}</body>
    </html>
  );
}
