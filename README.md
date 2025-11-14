# 오메가수학전문학원 웹앱

**당신의 마지막 수학, 오메가수학전문학원**

학원 전용 웹앱으로 공지사항, 질문게시판, 회원관리 등의 기능을 제공합니다.

---

## 🎯 프로젝트 개요

- **이름**: 오메가수학전문학원 웹앱
- **목표**: 학원 학생들과 선생님들이 소통할 수 있는 전용 플랫폼 제공
- **주요 기능**:
  - 로그인/회원관리 (관리자 전용)
  - 공지사항 게시판
  - 질문 게시판 (익명 기능, 답글/댓글)
  - 관리자 페이지
  - PWA 앱 설치 기능

---

## 🌐 접속 URL

### 개발 서버 (Sandbox)
- **URL**: https://3000-ifm5prrc58wojvgazcah5-de59bda9.sandbox.novita.ai
- **API Base**: https://3000-ifm5prrc58wojvgazcah5-de59bda9.sandbox.novita.ai/api

### 프로덕션 배포
- **프로젝트 다운로드**: https://page.gensparksite.com/project_backups/omega-academy-complete-with-guides.tar.gz
- **배포 가이드**: `QUICK_START.md` 또는 `DEPLOYMENT_GUIDE.md` 참고
- **자동 배포 스크립트**: `./deploy.sh production`

### 테스트 계정

| 역할 | 전화번호 | 비밀번호 | 이름 |
|------|----------|----------|------|
| 관리자 | 01012345678 | 900101 | 관리자 |
| 조교 | 01055556666 | 030520 | 김조교 |
| 학생 | 01098765432 | 050315 | 홍길동 |

---

## 📊 데이터 구조

### 데이터베이스 (Cloudflare D1 - SQLite)

#### 주요 테이블
1. **users** - 사용자 정보
   - 역할 (4단계): admin(관리자), teacher(선생님), assistant(조교), student(학생)
   - 로그인: 전화번호 + 생년월일(6자리)
   - 소프트 삭제 지원 (is_deleted 플래그)

2. **notices** - 공지사항
   - 제목, 내용, 이미지 첨부 가능
   - 관리자만 작성/수정/삭제

3. **questions** - 질문 게시판
   - 익명 작성 가능
   - 수정 횟수 추적
   - 소프트 삭제 (복구 가능)

4. **replies** - 답글
   - 익명 작성 가능
   - 조교/학생 모두 작성 가능

5. **comments** - 댓글
   - 답글에 대한 댓글
   - 익명 작성 가능

6. **deletion_logs** - 삭제 로그
   - 관리자가 모든 삭제 내역 확인 가능

### 파일 스토리지 (Cloudflare R2)
- 공지사항 이미지
- 질문 게시글 이미지
- 답글/댓글 이미지

---

## 🚀 현재 구현된 기능

### ✅ 완료된 기능

#### 1. 인증 시스템
- [x] 로그인 (전화번호 + 생년월일)
- [x] 자동 로그인 (JWT 토큰)
- [x] 로그아웃

#### 2. 공지사항
- [x] 공지사항 목록 조회
- [x] 공지사항 상세 보기
- [x] 공지사항 작성 (관리자)
- [x] 공지사항 수정 (관리자)
- [x] 공지사항 삭제 (관리자)
- [x] 이미지 첨부 기능

#### 3. 질문 게시판
- [x] 질문 목록 조회
- [x] 질문 상세 보기
- [x] 질문 작성 (익명 가능)
- [x] 질문 수정 (수정 횟수 표시)
- [x] 질문 삭제 (소프트 삭제)
- [x] 답글 작성 (익명 가능)
- [x] 답글 삭제
- [x] 댓글 작성 (익명 가능)
- [x] 댓글 삭제
- [x] 이미지 첨부 (질문/답글/댓글)
- [x] 조교 배지 표시

#### 4. 관리자 기능
- [x] 회원 목록 조회
- [x] 회원 추가/수정/삭제
- [x] 비밀번호 재설정
- [x] 역할 변경 (학생/조교/관리자)
- [x] 삭제 로그 조회
- [x] 통계 대시보드

#### 5. 알림 기능
- [x] 실시간 알림 시스템
- [x] 내 질문/답글에 회신 시 알림
- [x] 읽지 않은 알림 개수 표시
- [x] 알림 읽음 처리
- [x] 알림 삭제 기능
- [x] 알림 클릭 시 해당 게시글로 이동
- [x] 5분마다 자동 업데이트
- [x] **푸시 알림 (Web Push)** - 앱이 닫혀있어도 알림 수신
- [x] 사용자 메뉴에서 푸시 알림 켜기/끄기
- [x] 알림 권한 나중에 허용 가능
- [x] 앱 아이콘 배지 (Android 자동)

#### 6. PWA 기능
- [x] 모바일 앱처럼 설치 가능
- [x] iOS/Android 설치 가이드 제공
- [x] 플로팅 설치 버튼 자동 표시
- [x] 커스텀 Omega 로고 아이콘
- [x] 오프라인 지원 준비

#### 7. UI/UX
- [x] 반응형 디자인
- [x] 전문적이고 고급스러운 디자인
- [x] 블루 계열 그라디언트 테마
- [x] Font Awesome 아이콘
- [x] TailwindCSS 스타일링

---

## 📱 사용 방법

### 일반 사용자 (학생)
1. **로그인**: 전화번호와 생년월일(6자리) 입력
2. **공지사항 확인**: 학원의 최신 공지사항 확인
3. **질문 작성**: 모르는 문제를 질문으로 등록 (익명 가능)
4. **답글/댓글**: 다른 학생이나 조교의 답변 확인
5. **앱 설치**: 홈 화면에 추가하여 앱처럼 사용

### 선생님/조교
- 학생과 동일 + 질문에 답변 제공
- 선생님: 보라색 배지 표시
- 조교: 파란색 배지 표시

### 관리자
- 모든 기능 사용 가능
- 회원 관리 (추가/수정/삭제)
- 공지사항 작성/수정/삭제
- 삭제된 게시글 로그 확인
- 익명 게시글의 실제 작성자 확인

---

## 🛠 기술 스택

### Frontend
- HTML5 + Vanilla JavaScript
- TailwindCSS (CDN)
- Font Awesome Icons
- Axios (HTTP 클라이언트)
- Service Worker (PWA + Push 알림)

### Backend
- Hono Framework (Edge Runtime)
- TypeScript
- JWT 인증
- bcryptjs (비밀번호 암호화)
- web-push (푸시 알림 서버)

### Database & Storage
- Cloudflare D1 (SQLite 기반)
- Cloudflare R2 (이미지 스토리지)
- Push Subscriptions 테이블

### Deployment
- Cloudflare Pages (Edge Network)
- Wrangler CLI

---

## 🔧 로컬 개발 환경 설정

### 1. 프로젝트 클론
```bash
cd /home/user/webapp
```

### 2. 의존성 설치
```bash
npm install
```

### 3. 환경 변수 설정 (.dev.vars)
```bash
# VAPID 키는 이미 .dev.vars 파일에 설정되어 있습니다
# 프로덕션 배포 시에는 Cloudflare Secrets에 설정 필요
```

### 4. 데이터베이스 마이그레이션
```bash
npm run db:migrate:local
```

### 5. 프로젝트 빌드
```bash
npm run build
```

### 6. 개발 서버 시작
```bash
# 포트 정리
npm run clean-port

# PM2로 서버 시작
pm2 start ecosystem.config.cjs

# 또는 직접 실행
npm run dev:d1
```

### 7. 접속
```
http://localhost:3000
```

---

## 🌍 Cloudflare 배포 가이드

### 사전 준비
1. **Cloudflare 계정 생성**
   - https://dash.cloudflare.com/sign-up 에서 무료 계정 생성
   - 이메일 인증 완료

2. **API 토큰 발급**
   - Cloudflare 대시보드 → My Profile → API Tokens
   - "Create Token" 클릭
   - "Edit Cloudflare Workers" 템플릿 선택
   - 권한: Account - Cloudflare Pages (Edit), D1 (Edit), R2 (Edit)
   - 토큰 복사 후 안전한 곳에 보관

### 배포 단계

#### 1. Wrangler CLI 인증
```bash
# API 토큰으로 로그인
wrangler login
# 또는 환경변수 설정
export CLOUDFLARE_API_TOKEN=your-api-token
```

#### 2. D1 데이터베이스 생성
```bash
# 프로덕션 데이터베이스 생성
npx wrangler d1 create omega-academy-db

# 출력된 database_id를 wrangler.jsonc에 복사
# database_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

#### 3. R2 버킷 생성
```bash
npx wrangler r2 bucket create omega-academy-images
```

#### 4. wrangler.jsonc 수정
```jsonc
{
  "d1_databases": [
    {
      "binding": "DB",
      "database_name": "omega-academy-db",
      "database_id": "여기에-실제-database-id-입력"
    }
  ],
  "r2_buckets": [
    {
      "binding": "IMAGES",
      "bucket_name": "omega-academy-images"
    }
  ]
}
```

#### 5. 프로덕션 DB 마이그레이션
```bash
npm run db:migrate:prod
```

#### 6. **VAPID 키 Cloudflare Secrets에 설정 (중요!)**
```bash
# .dev.vars 파일의 값들을 Cloudflare Secrets에 설정
npx wrangler pages secret put VAPID_PUBLIC_KEY --project-name omega-academy
# 입력: BAlTAduv_Cu3GrlQhqv5DF1Js2dSQH1zi07-lgXJcvPLPCGhZY_bmp8lPqKwVM7tSQY5pBb_ACE6jybcrfQlOzE

npx wrangler pages secret put VAPID_PRIVATE_KEY --project-name omega-academy
# 입력: dz8lUpFFGCopNwkjoE0ZXkv--3B7bYewpL08qrm6QdE

npx wrangler pages secret put VAPID_SUBJECT --project-name omega-academy
# 입력: mailto:admin@omega-academy.com

# Secrets 목록 확인
npx wrangler pages secret list --project-name omega-academy
```

#### 7. Cloudflare Pages 프로젝트 생성
```bash
npx wrangler pages project create omega-academy \
  --production-branch main \
  --compatibility-date 2025-10-26
```

#### 8. 배포
```bash
# 빌드 및 배포
npm run deploy:prod
```

#### 9. 관리자 계정 생성
배포 완료 후 제공된 URL로 접속하여 curl로 관리자 계정 생성:
```bash
curl -X POST https://your-project.pages.dev/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"phone":"01012345678","password":"900101","name":"관리자","role":"admin"}'
```

#### 10. 푸시 알림 테스트
- 모바일 브라우저에서 접속
- 로그인 후 "알림 허용" 팝업에서 허용
- 다른 계정으로 답글 작성
- 앱을 닫아도 푸시 알림 수신 확인

---

## 📁 프로젝트 구조

```
webapp/
├── src/
│   ├── index.tsx              # 메인 애플리케이션 엔트리
│   ├── types/
│   │   └── index.ts           # TypeScript 타입 정의
│   ├── utils/
│   │   └── auth.ts            # 인증 유틸리티 (JWT, bcrypt)
│   ├── middleware/
│   │   └── auth.ts            # 인증 미들웨어
│   └── routes/
│       ├── auth.ts            # 인증 API
│       ├── notices.ts         # 공지사항 API
│       ├── questions.ts       # 질문게시판 API
│       ├── admin.ts           # 관리자 API
│       └── push.ts            # 푸시 알림 API (NEW)
├── public/
│   ├── sw.js                  # Service Worker (PWA + Push)
│   └── static/
│       ├── app.js             # 프론트엔드 JavaScript
│       ├── manifest.json      # PWA 매니페스트
│       ├── icon-192.png       # PWA 아이콘 (192x192)
│       └── icon-512.png       # PWA 아이콘 (512x512)
├── migrations/
│   ├── 0001_initial_schema.sql        # 초기 DB 스키마
│   ├── 0002_add_notifications.sql     # 알림 테이블
│   └── 0003_add_push_subscriptions.sql # 푸시 구독 테이블 (NEW)
├── .dev.vars                  # 로컬 환경변수 (VAPID 키)
├── ecosystem.config.cjs       # PM2 설정
├── wrangler.jsonc            # Cloudflare 설정
├── package.json              # 의존성 및 스크립트
└── README.md                 # 이 파일
```

---

## 🔐 보안 사항

- JWT 토큰은 30일 만료
- 비밀번호는 bcrypt로 암호화 저장
- CORS 설정으로 API 보호
- 관리자/조교 권한 체크 미들웨어
- 삭제된 데이터는 로그로 보존

---

## 🎨 디자인 특징

- **색상**: 블루 그라디언트 (전문성, 신뢰감)
- **폰트**: Noto Sans KR (한글 최적화)
- **반응형**: 모바일, 태블릿, 데스크톱 대응
- **아이콘**: Font Awesome 6.4.0
- **애니메이션**: 부드러운 전환 효과

---

## 📞 문의 및 지원

**오메가수학전문학원**
- 학원 관리자에게 문의하세요.

---

## 📝 업데이트 내역

### v1.3.0 (2025-10-29) - **최신**
- ✅ **푸시 알림 시스템 구현 (Web Push)**
  - 📱 앱을 열지 않아도 핸드폰에 알림 표시
  - 🔔 답글/댓글 작성 시 즉시 푸시 알림 발송
  - 🎯 Android: 앱 아이콘 배지 자동 표시
  - ⚙️ 사용자 메뉴에서 언제든지 알림 켜기/끄기 가능
  - 🚀 알림 클릭 시 해당 게시글로 바로 이동
  - ✨ 로그인 후 3초 뒤 알림 권한 요청 (한 번만, 나중에도 설정 가능)
  - 🔐 VAPID 인증으로 안전한 푸시 알림
  - 🗑️ 만료된 구독 자동 정리
  - 🌍 여러 기기에서 동시 구독 지원
- 📦 **새로운 API 엔드포인트**
  - `GET /api/push/vapid-public-key` - VAPID 공개 키 조회
  - `POST /api/push/subscribe` - 푸시 알림 구독
  - `POST /api/push/unsubscribe` - 푸시 알림 구독 해제
- 🗄️ **데이터베이스 스키마 추가**
  - `push_subscriptions` 테이블 (사용자별 푸시 구독 정보 저장)
  - user_id, endpoint, p256dh, auth 키 저장
  - 자동 중복 방지 (UNIQUE 제약조건)

### v1.2.0 (2025-10-28)
- ✅ **실시간 알림 시스템 구현**
  - 내 질문에 답글이 달리면 알림
  - 내 답글에 댓글이 달리면 알림
  - 헤더에 알림 아이콘 + 읽지 않은 개수 배지
  - 알림 클릭 시 해당 게시글로 이동
  - 알림 읽음 처리 및 삭제 기능
  - 5분마다 자동으로 알림 개수 업데이트
  - 자기 자신에게는 알림 보내지 않음

### v1.1.0 (2025-10-28)
- ✅ PWA 설치 버튼 수정 완료
- ✅ 4단계 역할 시스템 구현 (관리자/선생님/조교/학생)
- ✅ 시간 표시 UTC→KST 변환 수정
- ✅ 사용자 삭제 소프트 삭제로 변경
- ✅ 커스텀 Omega 로고 아이콘 추가
- ✅ 배포 가이드 및 스크립트 추가

### v1.0.0 (2025-10-26)
- ✅ 초기 버전 출시
- ✅ 모든 기본 기능 구현 완료
- ✅ 로컬 테스트 완료

---

## 🚧 향후 개발 계획

### 추가 예정 기능
- [ ] 프로필 이미지 업로드
- [ ] 검색 기능 (게시글 검색)
- [ ] 페이지네이션 (게시글 목록)
- [ ] 좋아요/추천 기능
- [ ] 파일 첨부 (PDF, 문서 등)
- [ ] 출석 체크 기능
- [ ] 성적 관리 기능
- [ ] 푸시 알림 커스터마이징 (알림 유형별 설정)

### 개선 예정 사항
- [ ] 이미지 최적화 및 리사이징
- [ ] 에러 처리 고도화
- [ ] 로딩 상태 개선
- [ ] 접근성(a11y) 개선
- [ ] 성능 최적화

---

## ⚙️ 유용한 명령어

```bash
# 개발
npm run dev              # Vite 개발 서버
npm run build            # 프로젝트 빌드
npm run preview          # 빌드 미리보기

# 데이터베이스
npm run db:migrate:local # 로컬 DB 마이그레이션
npm run db:migrate:prod  # 프로덕션 DB 마이그레이션
npm run db:reset         # 로컬 DB 초기화

# PM2
pm2 list                 # 프로세스 목록
pm2 logs                 # 로그 확인
pm2 restart omega-academy # 재시작
pm2 delete omega-academy  # 중지 및 삭제

# 배포
npm run deploy           # Cloudflare Pages 배포
npm run deploy:prod      # 프로덕션 배포
```

---

**Made with ❤️ for Omega Math Academy**
