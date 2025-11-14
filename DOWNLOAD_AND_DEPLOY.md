# 📦 다운로드 & 배포 - 완전 가이드

## 🎯 한눈에 보기

**프로젝트 이름:** 오메가수학전문학원 (Omega Academy)
**최종 업데이트:** 2025-10-28
**주요 기능:** PWA 설치 버튼 수정 완료

---

## 📥 다운로드

### 최종 완성 버전 다운로드

```
https://page.gensparksite.com/project_backups/omega-academy-complete-with-guides.tar.gz
```

**파일 크기:** 약 504 KB
**포함 내용:**
- ✅ 전체 소스 코드
- ✅ PWA 설치 기능 수정 완료
- ✅ 데이터베이스 마이그레이션 파일
- ✅ 배포 스크립트
- ✅ 상세 가이드 문서

---

## 🚀 가장 빠른 배포 방법 (3분)

### Windows

```powershell
# 1. 압축 해제
tar -xzf omega-academy-complete-with-guides.tar.gz
cd home\user\webapp

# 2. 의존성 설치
npm install

# 3. Cloudflare 로그인
npx wrangler login

# 4. 배포 (자동 스크립트)
.\deploy.sh production
```

### Mac/Linux

```bash
# 1. 압축 해제
tar -xzf omega-academy-complete-with-guides.tar.gz
cd home/user/webapp

# 2. 의존성 설치
npm install

# 3. Cloudflare 로그인
npx wrangler login

# 4. 배포 (자동 스크립트)
./deploy.sh production
```

**배포 완료 후 URL:** https://omega-academy.pages.dev

---

## 📝 포함된 가이드 문서

프로젝트에 다음 문서들이 포함되어 있습니다:

### 1. `QUICK_START.md` ⭐ (처음 보세요!)
- 가장 빠른 시작 가이드
- 3단계로 배포 완료
- 문제 해결 팁

### 2. `DEPLOYMENT_GUIDE.md` 📚
- 상세 배포 가이드
- GitHub 연동 자동 배포 방법
- 데이터베이스 관리
- 환경 변수 설정
- 문제 해결 가이드

### 3. `deploy.sh` 🤖
- 자동 배포 스크립트
- 로컬/프로덕션 환경 지원
- 사용법:
  ```bash
  ./deploy.sh local       # 로컬 개발
  ./deploy.sh production  # 프로덕션 배포
  ```

### 4. `README.md` 📖
- 프로젝트 개요
- 기능 설명
- 기술 스택

---

## 🔧 수동 배포 (단계별)

자동 스크립트를 사용하지 않고 직접 하시려면:

```bash
# 1. 프로젝트 폴더로 이동
cd home/user/webapp

# 2. 의존성 설치
npm install

# 3. Cloudflare 로그인 (브라우저가 열림)
npx wrangler login

# 4. 프로젝트 빌드
npm run build

# 5. 데이터베이스 마이그레이션
npx wrangler d1 migrations apply omega-academy-db --remote

# 6. Cloudflare Pages에 배포
npx wrangler pages deploy dist --project-name omega-academy
```

---

## ✅ 최근 수정사항

### PWA 설치 버튼 개선 (2025-10-28)

**문제:**
- PWA 설치 버튼 클릭 시 "브라우저에서 앱 설치가 지원되지 않습니다" 오류
- 플로팅 설치 버튼이 나타나지 않음

**해결:**
- ✅ `showBrowserInstallGuide()` 함수 구현
- ✅ Android/PC Chrome/Edge 사용자를 위한 수동 설치 안내 추가
- ✅ 플로팅 버튼 자동 표시 로직 개선
- ✅ iOS Safari 사용자를 위한 별도 안내 유지

**수정된 파일:**
- `public/static/app.js` (라인 1843-1953)

---

## 🗄️ 데이터베이스 구조

### 주요 테이블

1. **users** - 사용자 (4개 역할 지원)
   - `admin` (관리자)
   - `teacher` (선생님)
   - `assistant` (조교)
   - `student` (학생)

2. **notices** - 공지사항

3. **questions** - 질문
   - 다중 이미지 첨부 지원
   - Cloudflare R2 스토리지 사용

4. **replies** - 답글 (선생님/조교 전용)

5. **comments** - 댓글

6. **deletion_logs** - 삭제 로그

### 마이그레이션 파일
```
migrations/
├── 0001_initial_schema.sql      # 초기 스키마
├── 0002_add_multiple_images.sql # 다중 이미지
├── 0003_add_user_profile.sql    # 사용자 프로필
└── 0004_add_user_soft_delete.sql # 소프트 삭제
```

---

## 🎨 주요 기능

### 일반 사용자
- ✅ 회원가입/로그인
- ✅ 질문 작성 (다중 이미지 첨부)
- ✅ 댓글 작성
- ✅ 공지사항 확인
- ✅ PWA 앱 설치

### 선생님/조교
- ✅ 질문에 답글 작성
- ✅ 학생 질문 관리
- ✅ 공지사항 읽기

### 관리자
- ✅ 회원 관리 (추가/수정/삭제)
- ✅ 공지사항 관리 (작성/수정/삭제)
- ✅ 질문/답글/댓글 관리
- ✅ 삭제 로그 확인
- ✅ 역할 4단계 관리

---

## 🔐 보안

- JWT 기반 인증
- bcryptjs 비밀번호 암호화
- 역할 기반 권한 관리 (RBAC)
- Soft Delete (데이터 복구 가능)
- Rate Limiting (API 호출 제한)

---

## 🌐 기술 스택

**Frontend:**
- Vanilla JavaScript (ES6+)
- TailwindCSS (CDN)
- FontAwesome Icons
- Axios

**Backend:**
- Hono (Edge Framework)
- TypeScript
- Cloudflare Workers

**Database & Storage:**
- Cloudflare D1 (SQLite)
- Cloudflare R2 (Object Storage)

**Deployment:**
- Cloudflare Pages
- Wrangler CLI

---

## 📞 추가 지원

### 공식 문서
- Cloudflare Pages: https://developers.cloudflare.com/pages/
- Wrangler CLI: https://developers.cloudflare.com/workers/wrangler/
- Hono Framework: https://hono.dev/

### 프로젝트 문서
- `QUICK_START.md` - 빠른 시작
- `DEPLOYMENT_GUIDE.md` - 상세 배포 가이드
- `README.md` - 프로젝트 개요
- `ADMIN_GUIDE.md` - 관리자 가이드

---

## 🎯 다음 단계

1. **프로젝트 다운로드**
   ```
   https://page.gensparksite.com/project_backups/omega-academy-complete-with-guides.tar.gz
   ```

2. **압축 해제**
   ```bash
   tar -xzf omega-academy-complete-with-guides.tar.gz
   cd home/user/webapp
   ```

3. **QUICK_START.md 읽기**
   - 가장 빠른 배포 방법 확인

4. **배포 실행**
   ```bash
   npm install
   npx wrangler login
   ./deploy.sh production
   ```

5. **테스트**
   - https://omega-academy.pages.dev 접속
   - 회원가입 및 기능 테스트

---

**완료! 🎉**

프로젝트를 다운로드하시고, 위의 단계를 따라하시면 됩니다.
문제가 생기면 `DEPLOYMENT_GUIDE.md`의 문제 해결 섹션을 참고하세요!

---

**백업 다운로드:**
- 최종 버전: https://page.gensparksite.com/project_backups/omega-academy-complete-with-guides.tar.gz
- PWA 수정 버전: https://page.gensparksite.com/project_backups/omega-academy-pwa-install-fix.tar.gz
