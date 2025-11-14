# 배포 지침

## ⚠️ 중요: 마이그레이션 실패 시

마이그레이션 0005가 FOREIGN KEY 제약조건 때문에 실패합니다.

## ✅ 해결 방법

### 방법 1: 수동 SQL 실행 (권장)

프로덕션 DB에서 직접 실행:

```bash
# 선생님 역할을 assistant로 임시 변환
npx wrangler d1 execute omega-academy-db --remote --command="UPDATE users SET role='assistant' WHERE role='teacher';"
```

그 후:
1. 관리자 페이지에서 해당 사용자 찾기
2. 권한을 다시 "선생님"으로 변경
3. 이번에는 assistant로 저장되지만, 프론트엔드에서 teacher로 표시

### 방법 2: 마이그레이션 건너뛰기

마이그레이션 없이 배포:

```bash
cd C:\Users\skyga\OneDrive\바탕 화면\omega-academy\webapp
npm install
set CLOUDFLARE_API_TOKEN=your-token-here

# 마이그레이션 스킵!
npm run build
npx wrangler pages deploy dist --project-name omega-academy
```

**선생님 권한은 다음과 같이 작동합니다:**
- DB에는 'student', 'admin', 'assistant'만 허용
- 백엔드에서 'teacher'를 'assistant'로 자동 변환
- 프론트엔드에서 school 필드로 구분하여 표시

## 배포 명령어

```bash
npm run build
npx wrangler pages deploy dist --project-name omega-academy
```
