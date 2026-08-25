# AI홈페이지스쿨 공식 홈페이지

AI 시대, 1인기업과 소상공인이 자신의 공식 홈페이지를 직접 기획·제작·배포하고
AIO 최적화 점검까지 경험하는 4주 실전 교육 브랜드의 공식 사이트입니다.

- 운영: 거상스쿨(주) / 거상마케팅센터
- 배포: https://aihomepage-school.vercel.app

## 페이지 구조

| URL | 파일 | 내용 |
| --- | --- | --- |
| `/` | `index.html` | 홈 랜딩페이지 (Hero, 문제 제기, AIO, 도서 4권, 4주 커리큘럼, 강사 소개, 제작사례, 가격, FAQ) |
| `/about` | `about/index.html` | 스쿨 소개 — 브랜드 철학, 8가지 원칙, 8개 대상 고객, 대표 소개 |
| `/curriculum` | `curriculum/index.html` | 4주 커리큘럼 상세 |
| `/aio` | `aio/index.html` | AIO 홈페이지 전략 |
| `/schemaworks` | `schemaworks/index.html` | schemaWorks AIO 최적화 진단 |
| `/examples` | `examples/index.html` | 제작사례 |
| `/apply` | `apply/index.html` | 수강 안내 · 신청 |
| — | `404.html` | 404 페이지 |

## 부가 파일

- `vercel.json` — cleanUrls 설정 (`/about` 형태 주소 지원), 캐시·보안 헤더
- `robots.txt` — 일반 검색엔진 + AI 크롤러(GPTBot, ClaudeBot, PerplexityBot 등) 허용
- `sitemap.xml` — 7개 페이지 사이트맵
- `llms.txt` — LLM용 사이트 요약
- `og-image.png` — 공유 미리보기 이미지
- `assets/` — 로고, 대표 프로필, 도서 표지, 제작사례 썸네일, 도구 아이콘
- `support.js` — 홈 페이지 런타임 (FAQ 토글, 모바일 메뉴)

## 배포 방법

### 1. GitHub 저장소에 업로드

이 폴더(`deploy/`)의 **내용물**을 저장소 루트에 올립니다.

```
your-repo/
├── index.html
├── 404.html
├── vercel.json
├── robots.txt
├── sitemap.xml
├── llms.txt
├── og-image.png
├── support.js
├── assets/
├── about/
├── curriculum/
├── aio/
├── schemaworks/
├── examples/
└── apply/
```

```bash
git init
git add .
git commit -m "AI홈페이지스쿨 사이트"
git branch -M main
git remote add origin https://github.com/<계정>/<저장소>.git
git push -u origin main
```

### 2. Vercel 연결

1. vercel.com → **Add New… → Project**
2. 위 GitHub 저장소 선택
3. Framework Preset: **Other**
4. Build Command / Output Directory: **비워둠** (정적 사이트)
5. Deploy

이후 `main` 브랜치에 push하면 자동 재배포됩니다.

### 3. 커스텀 도메인 연결

Vercel 프로젝트 → Settings → Domains → 도메인 입력 → 안내되는 A 레코드 또는 CNAME을 도메인 등록업체 DNS에 추가.

도메인을 바꾼 경우 아래 파일의 주소를 함께 교체해야 합니다.

- 각 HTML의 `canonical`, `og:url`, `og:image`, JSON-LD
- `sitemap.xml`
- `robots.txt`의 Sitemap 줄
- `llms.txt`

## 배포 후 체크리스트

- [ ] `/about` `/curriculum` `/aio` `/schemaworks` `/examples` `/apply` 직접 접속 시 404 없음
- [ ] 각 페이지 새로고침 정상
- [ ] 모바일 햄버거 메뉴 동작
- [ ] 카카오톡·페이스북 공유 미리보기 이미지 노출
- [ ] 구글 서치콘솔 등록 + sitemap 제출
- [ ] 네이버 서치어드바이저 등록 + sitemap 제출
- [ ] schemaWorks(https://schemaworks.thevuemedia.com/) AIO 진단

## 남은 작업

- GA4 측정 ID 발급 시 전 페이지 `<head>`에 삽입
- `/apply` 신청 버튼: 현재 `#apply-form` 앵커 → 구글폼 주소로 교체
- `/examples` 제작사례 6건: 신규 수료 사례가 생길 때 실제 캡처·URL로 업데이트
