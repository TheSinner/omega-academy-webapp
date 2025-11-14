# 빠른 시작 가이드 (Quick Start)

## 📥 1단계: 프로젝트 다운로드

**다운로드 링크:**
```
https://page.gensparksite.com/project_backups/omega-academy-pwa-install-fix.tar.gz
```

**압축 해제:**
```bash
# Windows/Mac/Linux 모두 가능
tar -xzf omega-academy-pwa-install-fix.tar.gz

# 프로젝트 폴더로 이동
cd home/user/webapp
```

---

## 🚀 2단계: 로컬에서 배포하기

### 필수 준비사항
- Node.js 18 이상 설치 (https://nodejs.org/)
- Cloudflare 계정 (https://dash.cloudflare.com/)

### 간단한 배포 (3단계)

```bash
# 1. 의존성 설치
npm install

# 2. Cloudflare 로그인 (브라우저가 열림)
npx wrangler login

# 3. 배포!
./deploy.sh production
```

### 또는 한 줄씩 실행

```bash
# 1. 의존성 설치
npm install

# 2. Cloudflare 로그인
npx wrangler login

# 3. 빌드
npm run build

# 4. 데이터베이스 마이그레이션
npx wrangler d1 migrations apply omega-academy-db --remote

# 5. 배포
npx wrangler pages deploy dist --project-name omega-academy
```

---

## ✅ 3단계: 배포 확인

배포 완료 후 터미널에 나오는 URL로 접속:
```
https://omega-academy.pages.dev
```

**테스트 계정:**
- 회원가입 후 사용
- 또는 기존 데이터베이스가 있다면 기존 계정 사용

---

## 🔄 코드 수정 후 재배포

```bash
# 코드 수정 후
npm run build
npx wrangler pages deploy dist
```

---

## 🆘 문제가 생겼다면?

### "wrangler: command not found"
```bash
npm install -g wrangler
```

### "You need to be logged in"
```bash
npx wrangler login
```

### 빌드 에러
```bash
rm -rf node_modules dist
npm install
npm run build
```

---

## 📚 더 자세한 내용은?

`DEPLOYMENT_GUIDE.md` 파일을 참고하세요!
- GitHub 연동 자동 배포
- 데이터베이스 관리
- 환경 변수 설정
- 문제 해결 가이드

---

**최종 수정:** 2025-10-28
