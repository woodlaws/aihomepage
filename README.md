# 게시판 설치 안내 (5분)

## 1. 폴더 복사

`board` 폴더를 통째로 `aihomepage` 저장소 최상단에 넣습니다.

```
aihomepage/
├── index.html
├── vercel.json
├── about/
├── curriculum/
├── apply/
└── board/          ← 이 폴더를 추가
    ├── index.html   목록
    ├── write.html   글쓰기
    ├── view.html    상세보기
    ├── config.js    설정 (여기만 수정)
    ├── style.css    디자인
    └── README.md    이 문서
```

## 2. 키 넣기 (여기만 수정하면 끝)

`board/config.js` 파일을 열어 3번째 줄 아래의 `SUPABASE_KEY` 값을 바꿉니다.

```js
export const SUPABASE_KEY = '여기에_sb_publishable_키를_붙여넣으세요';
```

Supabase 대시보드 → Project Settings → API Keys → **Publishable key** 의 복사 버튼을 눌러 얻은
`sb_publishable_...` 값을 따옴표 안에 붙여넣습니다.

`SUPABASE_URL` 은 이미 채워져 있으므로 건드리지 않아도 됩니다.

## 3. 배포

```bash
git add board
git commit -m "고객게시판 추가"
git push
```

Vercel이 자동으로 배포합니다. 1분 뒤 `https://aihomepage-school.vercel.app/board/` 로 접속하면 됩니다.

## 4. 메인 사이트에 링크 걸기

메인 `index.html` 의 네비게이션에 아래 한 줄을 추가하면 방문자가 게시판으로 들어올 수 있습니다.

```html
<a href="/board/">고객게시판</a>
```

---

# 관리 방법

## 공지 등록하기

Supabase 대시보드 → Table Editor → `posts` → **Insert row**

| 컬럼 | 입력값 |
|---|---|
| title | 공지 제목 |
| content | 공지 내용 |
| author_name | 관리자 |
| is_notice | **true 체크** |

`is_notice` 를 true로 하면 목록 맨 위에 빨간 "공지" 딱지와 함께 고정됩니다.

## 답변 달기

Supabase 대시보드 → Table Editor → `replies` → **Insert row**

| 컬럼 | 입력값 |
|---|---|
| post_id | 답변할 글의 번호 (posts 테이블의 id) |
| content | 답변 내용 |

답변이 달린 글은 목록에서 "답변완료" 표시가 붙습니다.

## 글 삭제하기

Table Editor → `posts` → 해당 행 왼쪽 체크 → 우측 상단 Delete

---

# 이 게시판에 이미 들어있는 것

| 기능 | 설명 |
|---|---|
| 공지 상단 고정 | `is_notice = true` 인 글이 맨 위에 |
| 작성자 마스킹 | 임헌수 → 임** |
| 페이징 | 10개씩, 5페이지 블록 단위 |
| 조회수 | 같은 브라우저에서 24시간 내 중복 카운트 안 함 |
| 답변 표시 | 상세 페이지 하단에 파란 박스로 |
| 답변완료 뱃지 | 목록에서 답변 여부 확인 |
| 모바일 대응 | 700px 이하에서 표가 카드형으로 전환 |
| XSS 방지 | 입력값 전부 이스케이프 처리 |
| 스팸 차단 | 함정 필드 + 3초 미만 제출 차단 |

---

# 아직 없는 것 (다음 단계)

| 기능 | 필요한 작업 |
|---|---|
| 비밀글 (자물쇠) | 서버 함수 + 비밀번호 해시 |
| 작성자 본인 수정·삭제 | 위와 동일 |
| 관리자 로그인 화면 | Supabase Auth |
| 파일 첨부 | Supabase Storage |
| 문의 알림 (카톡·메일) | Supabase Edge Function + 외부 API |

---

# 문제가 생기면

| 증상 | 원인 | 해결 |
|---|---|---|
| 목록이 계속 "불러오는 중" | 키를 안 넣었거나 잘못 넣음 | `config.js` 의 SUPABASE_KEY 확인 |
| "목록을 불러오지 못했습니다" | RLS 정책 누락 | Supabase SQL Editor에서 정책 SQL 재실행 |
| 글쓰기 시 policy 오류 | insert 정책 누락 | 위와 동일 |
| 어제까지 되다가 오늘 안 됨 | 7일 미접속으로 프로젝트 일시정지 | Supabase 대시보드에서 Restore |

브라우저에서 `F12` → Console 탭을 열면 실제 오류 메시지를 볼 수 있습니다.
