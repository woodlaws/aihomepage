// ============================================
//  Supabase 연결 설정
//  ⚠️ 아래 KEY 값만 본인 것으로 바꾸세요.
// ============================================

export const SUPABASE_URL = 'https://edvttdecrjmjpctqadvm.supabase.co';

// Supabase 대시보드 → Project Settings → API Keys → Publishable key
// sb_publishable_ 로 시작하는 값을 그대로 붙여넣으세요.
export const SUPABASE_KEY = 'sb_publishable_Dhij1WoCM3z1lQ8UrzuDvA_lbW7b5Yz';

// 한 페이지에 보여줄 글 개수
export const PAGE_SIZE = 10;

// 작성자명 마스킹 (홍길동 → 홍**)
export function maskName(name) {
  if (!name) return '익명';
  const s = String(name).trim();
  if (s.length <= 1) return s + '**';
  return s[0] + '*'.repeat(Math.min(s.length - 1, 2));
}

// 날짜 포맷 (2026.08.25)
export function formatDate(iso) {
  const d = new Date(iso);
  const p = (n) => String(n).padStart(2, '0');
  return `${d.getFullYear()}.${p(d.getMonth() + 1)}.${p(d.getDate())}`;
}

// HTML 이스케이프 (XSS 방지)
export function esc(str) {
  return String(str == null ? '' : str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}
