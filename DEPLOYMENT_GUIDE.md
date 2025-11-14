# 오메가수학전문학원 배포 가이드

## 📦 프로젝트 다운로드

**백업 파일 다운로드:**
```
https://page.gensparksite.com/project_backups/omega-academy-pwa-install-fix.tar.gz
```

**압축 해제:**
```bash
# Windows (PowerShell)
tar -xzf omega-academy-pwa-install-fix.tar.gz

# Mac/Linux
tar -xzf omega-academy-pwa-install-fix.tar.gz

# 압축 해제 후 프로젝트 폴더로 이동
cd home/user/webapp
```

---

## 🔧 로컬 환경 설정

### 1. Node.js 설치 확인
```bash
node --version  # v18 이상 필요
npm --version
```

Node.js가 없다면: https://nodejs.org/ 에서 LTS 버전 다운로드

### 2. 의존성 설치
```bash
npm install
```

### 3. 로컬 개발 서버 실행 (선택사항)
```bash
# 빌드
npm run build

# 로컬 테스트
npm run dev:d1

# 브라우저에서 http://localhost:3000 접속
```

---

## ☁️ Cloudflare Pages 배포

### 방법 1: 자동 배포 (GitHub 연동) - 권장 ⭐

#### Step 1: GitHub에 코드 업로드
```bash
# GitHub에서 새 저장소 생성 (예: omega-academy)
# 터미널에서 실행:

git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/omega-academy.git
git push -u origin main
```

#### Step 2: Cloudflare Pages 연결
1. Cloudflare 대시보드 접속: https://dash.cloudflare.com/
2. 좌측 메뉴에서 **Workers & Pages** 클릭
3. **Create application** → **Pages** → **Connect to Git** 선택
4. GitHub 저장소 선택: `omega-academy`
5. 빌드 설정:
   ```
   Production branch: main
   Build command: npm run build
   Build output directory: dist
   ```
6. **Environment variables** 추가 (선택):
   - 필요시 환경 변수 추가
7. **Save and Deploy** 클릭

#### Step 3: D1 데이터베이스 연결
```bash
# 프로덕션 데이터베이스 마이그레이션
npx wrangler d1 migrations apply omega-academy-db --remote
```

Cloudflare 대시보드에서:
1. **Workers & Pages** → **omega-academy** 프로젝트 선택
2. **Settings** → **Functions** → **D1 database bindings**
3. **Add binding**:
   - Variable name: `DB`
   - D1 database: `omega-academy-db` 선택
4. **Save** 클릭

**장점:**
- 이후 git push만 하면 자동으로 배포됨
- 배포 히스토리 관리 자동화
- Rollback 쉬움

---

### 방법 2: Wrangler CLI로 수동 배포

#### Step 1: Wrangler 설치 및 로그인
```bash
# Wrangler CLI 설치 (전역)
npm install -g wrangler

# Cloudflare 로그인 (브라우저가 열리며 인증)
npx wrangler login
```

#### Step 2: 프로젝트 빌드
```bash
npm run build
```

#### Step 3: 배포
```bash
# 첫 배포
npx wrangler pages deploy dist --project-name omega-academy

# 이후 배포 (프로젝트 이름 생략 가능)
npx wrangler pages deploy dist
```

#### Step 4: D1 데이터베이스 마이그레이션
```bash
# 프로덕션 데이터베이스에 마이그레이션 적용
npx wrangler d1 migrations apply omega-academy-db --remote
```

---

## 🗄️ 데이터베이스 관리

### 로컬 데이터베이스
```bash
# 로컬 마이그레이션 적용
npm run db:migrate:local

# 로컬 데이터베이스 초기화
npm run db:reset

# 로컬 데이터베이스 쿼리
npm run db:console:local
# 예: SELECT * FROM users;
```

### 프로덕션 데이터베이스
```bash
# 프로덕션 마이그레이션 적용
npm run db:migrate:prod

# 프로덕션 데이터베이스 쿼리
npm run db:console:prod
# 예: SELECT * FROM users;

# 프로덕션 데이터 조회
npx wrangler d1 execute omega-academy-db --remote --command="SELECT * FROM users LIMIT 10"
```

---

## 🔑 환경 변수 설정 (필요시)

### 로컬 환경
`.dev.vars` 파일 생성:
```bash
# .dev.vars (로컬 개발용)
JWT_SECRET=your-secret-key-here
```

### 프로덕션 환경
```bash
# Cloudflare Pages 시크릿 설정
npx wrangler pages secret put JWT_SECRET --project-name omega-academy
# 프롬프트에서 시크릿 값 입력

# 시크릿 목록 확인
npx wrangler pages secret list --project-name omega-academy
```

또는 Cloudflare 대시보드에서:
1. **Workers & Pages** → **omega-academy**
2. **Settings** → **Environment variables**
3. **Add variable** 클릭
4. 변수 이름과 값 입력 후 **Encrypt** 체크
5. **Save** 클릭

---

## 📋 주요 변경사항 (최근 업데이트)

### PWA 설치 버튼 개선
- `showBrowserInstallGuide()` 함수 추가
- Android/PC Chrome/Edge 사용자를 위한 수동 설치 안내
- 플로팅 설치 버튼 자동 표시 로직 개선
- iOS 사용자를 위한 별도 안내 유지

**수정된 파일:**
- `/public/static/app.js` (라인 1843-1953)

---

## 🚀 배포 확인

배포 후 다음을 확인하세요:

1. **프로덕션 URL 접속**
   - Cloudflare Pages: `https://omega-academy.pages.dev`
   - 커스텀 도메인: 설정한 경우

2. **기능 테스트**
   - 로그인/회원가입
   - 질문 작성 및 조회
   - 이미지 업로드
   - PWA 설치 버튼 동작
   - 사용자 정보 조회

3. **데이터베이스 확인**
   ```bash
   npx wrangler d1 execute omega-academy-db --remote --command="SELECT COUNT(*) as user_count FROM users"
   ```

4. **PWA 설치 테스트**
   - 모바일 브라우저에서 접속
   - 플로팅 "앱 설치" 버튼 확인
   - 사용자 메뉴 → "앱 설치하기" 클릭
   - 설치 후 홈 화면에서 앱 아이콘 확인

---

## 🔄 업데이트 및 재배포

### GitHub 연동 배포 (자동)
```bash
# 코드 수정 후
git add .
git commit -m "Update description"
git push origin main
# → 자동으로 배포됨
```

### Wrangler CLI 배포 (수동)
```bash
# 코드 수정 후
npm run build
npx wrangler pages deploy dist
```

---

## 🐛 문제 해결

### 배포 실패 시
```bash
# 로그 확인
cat ~/.config/.wrangler/logs/wrangler-*.log

# 빌드 캐시 삭제
rm -rf dist .wrangler node_modules
npm install
npm run build
```

### D1 데이터베이스 연결 오류
```bash
# 바인딩 확인
npx wrangler pages project list
npx wrangler d1 list

# 마이그레이션 재적용
npx wrangler d1 migrations apply omega-academy-db --remote
```

### 정적 파일 404 오류
- `/public/static/` 폴더 확인
- `manifest.json`, `icon-192.png`, `icon-512.png` 파일 존재 확인
- 빌드 후 `dist/` 폴더에 파일들이 복사되었는지 확인

---

## 📞 도움이 필요하면

- Cloudflare 문서: https://developers.cloudflare.com/pages/
- Wrangler 문서: https://developers.cloudflare.com/workers/wrangler/
- Hono 문서: https://hono.dev/

---

## 📊 프로젝트 구조

```
webapp/
├── src/
│   ├── index.tsx              # Hono 앱 진입점
│   └── routes/                # API 라우트
│       ├── admin.ts           # 관리자 API
│       ├── auth.ts            # 인증 API
│       ├── notices.ts         # 공지사항 API
│       ├── questions.ts       # 질문 API
│       ├── upload.ts          # 이미지 업로드 API
│       └── users.ts           # 사용자 API
├── public/
│   └── static/
│       ├── app.js             # 프론트엔드 JavaScript
│       ├── styles.css         # 커스텀 CSS
│       ├── icon-192.png       # PWA 아이콘 (192x192)
│       ├── icon-512.png       # PWA 아이콘 (512x512)
│       └── manifest.json      # PWA 매니페스트
├── migrations/                # D1 데이터베이스 마이그레이션
│   ├── 0001_init.sql
│   ├── 0002_add_notices.sql
│   ├── 0003_add_deletion_tracking.sql
│   ├── 0004_add_school_column.sql
│   └── 0005_add_teacher_role.sql
├── wrangler.jsonc             # Cloudflare 설정
├── vite.config.ts             # Vite 빌드 설정
├── package.json               # 의존성 및 스크립트
├── ecosystem.config.cjs       # PM2 설정 (개발용)
└── tsconfig.json              # TypeScript 설정
```

---

**마지막 업데이트:** 2025-10-28
**버전:** PWA Install Button Fix
