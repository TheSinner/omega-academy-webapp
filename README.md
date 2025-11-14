# omega-academy-webapp
오메가수학전문학원 웹앱


## 🤖 AI 협업 가이드

### 프로젝트 컨텍스트
이 프로젝트는 학원 전용 웹앱으로, 다음 기능들이 구현되어 있습니다:
- JWT 기반 인증 시스템
- 공지사항/질문 게시판
- 실시간 알림 + Web Push 알림
- PWA (Progressive Web App)
- Cloudflare Pages/Workers/D1/R2 사용

### 주요 기술 스택
- **Frontend**: Vanilla JS, TailwindCSS (CDN)
- **Backend**: Hono (TypeScript, Edge Runtime)
- **Database**: Cloudflare D1 (SQLite)
- **Storage**: Cloudflare R2
- **Push**: Web Push API + VAPID

### 개발 환경 설정
```bash
npm install
npm run db:migrate:local
npm run build
pm2 start ecosystem.config.cjs
