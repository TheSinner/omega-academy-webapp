# 🍎 iOS 캐시 문제 해결 가이드

## 📌 문제 상황

iOS/iPadOS에서 웹앱을 업데이트했는데도 **구버전이 계속 표시**되는 문제

---

## ✅ 적용된 해결책

### 1. LocalStorage 버전 체크 시스템

**동작 원리:**
```javascript
페이지 로드 시
    ↓
LocalStorage에서 저장된 버전 확인
    ↓
서버의 버전과 다르면?
    ↓
✨ 자동으로 강제 새로고침!
```

**코드 위치:** `src/index.tsx` (약 145번째 줄)

### 2. iOS 전용 강제 새로고침

iOS는 일반 `reload()`가 제대로 작동하지 않아서:

```javascript
// ❌ iOS에서 작동 안함
window.location.reload(true);

// ✅ iOS에서 작동
window.location.href = window.location.href + '?_t=' + Date.now();
```

타임스탬프를 추가해서 완전히 새로운 URL로 인식시킵니다.

### 3. 추가 iOS 최적화

- ✅ `viewport-fit=cover` - 노치 영역 대응
- ✅ `maximum-scale=1.0` - 확대/축소 방지
- ✅ 180x180 Apple Touch Icon 명시

---

## 🚀 이제 작동 방식

### iOS Safari 또는 홈 화면 앱에서:

```
1. 앱 실행
    ↓
2. 버전 체크 (즉시)
    ↓
3-A. 같은 버전이면
    → 정상 로드
    
3-B. 다른 버전이면
    → 자동 새로고침 (사용자 모름)
    → 최신 버전 로드
```

**특징:**
- ✅ 팝업 없음 (자동 처리)
- ✅ 즉시 적용
- ✅ 사용자 경험 방해 안함

---

## 📱 iOS 테스트 방법

### 1️⃣ 현재 버전 확인

Safari에서:
1. 사이트 접속
2. 개발자 도구 열기 (설정 → Safari → 고급 → 웹 속성 표시)
3. Mac Safari → 개발 → iPad/iPhone 선택
4. Console 탭에서:
   ```
   localStorage.getItem('app_version')
   // 출력: "1.1.2"
   ```

### 2️⃣ 강제 업데이트 테스트

```javascript
// Console에서 실행
localStorage.setItem('app_version', '1.1.1');
location.reload();

// 결과: 자동으로 1.1.2로 업데이트됨
```

### 3️⃣ 홈 화면 앱 테스트

1. Safari → 공유 → 홈 화면에 추가
2. 홈 화면에서 앱 실행
3. Console 로그 확인 (Mac Safari 개발자 도구)

---

## 🔄 버전 업데이트 프로세스 (iOS 포함)

### 배포 시:

```powershell
# 1. 버전 번호 변경
# src/index.tsx → APP_VERSION = '1.1.3'
# public/sw.js → CACHE_VERSION = '1.1.3'

# 2. 빌드 & 배포
npm run build
npx wrangler pages deploy dist --project-name omega-academy
```

### iOS 사용자가 보는 것:

```
앱 실행
    ↓
[화면 깜빡임 1초] ← 자동 새로고침
    ↓
✨ 최신 버전 로드 완료!
```

**Android/Windows와의 차이:**
- Android/Windows: 팝업 → 확인 → 새로고침
- iOS: 자동 새로고침 (팝업 없음)

---

## ⚠️ 주의사항

### 1. 첫 방문 시

```
최초 방문
    ↓
LocalStorage에 버전 저장 (1.1.2)
    ↓
다음 방문
    ↓
버전 체크 → 같으면 정상 로드
```

### 2. 캐시 완전 삭제 방법

**Settings → Safari → Clear History and Website Data**

또는 코드로:
```javascript
localStorage.clear();
location.reload();
```

### 3. iOS 시크릿 모드

시크릿 모드에서는 LocalStorage가 제한적으로 작동할 수 있습니다.
→ 일반 모드 또는 홈 화면 앱 권장

---

## 🐛 문제 해결

### Q1: iOS에서 여전히 구버전이 보여요

**A: 다음을 시도하세요:**

1. **완전 종료 후 재실행**
   ```
   앱 스와이프로 완전 종료
       ↓
   홈 버튼 두 번 눌러 앱 스위처
       ↓
   위로 스와이프
       ↓
   다시 앱 실행
   ```

2. **Safari 캐시 삭제**
   ```
   설정 → Safari → 방문 기록 및 웹사이트 데이터 지우기
   ```

3. **앱 재설치**
   ```
   홈 화면에서 앱 아이콘 길게 누르기
       ↓
   "앱 제거"
       ↓
   Safari로 다시 방문 → 홈 화면에 추가
   ```

### Q2: Console에서 "Version changed" 메시지가 안 보여요

**A: 버전이 실제로 같은지 확인:**
```javascript
// Console에서
console.log('Current:', '${APP_VERSION}');
console.log('Stored:', localStorage.getItem('app_version'));
```

### Q3: 무한 새로고침이 발생해요

**A: LocalStorage 초기화:**
```javascript
localStorage.removeItem('app_version');
location.reload();
```

---

## 📊 iOS vs Android 비교

| 항목 | iOS | Android/Windows |
|------|-----|-----------------|
| 업데이트 방식 | 자동 (즉시) | 팝업 선택 |
| 사용자 알림 | 없음 | 팝업 표시 |
| Service Worker | 제한적 | 완전 지원 |
| 캐시 정책 | 공격적 | 표준 |
| 강제 새로고침 | 타임스탬프 | reload(true) |

---

## 🎯 최종 확인 사항

배포 후 iOS에서:

✅ **Safari 브라우저**
- [ ] URL 접속 → 최신 버전 확인
- [ ] Console 로그 확인
- [ ] 기능 정상 작동 확인

✅ **홈 화면 앱**
- [ ] 앱 실행 → 자동 업데이트 확인
- [ ] 아이콘 표시 확인
- [ ] 오프라인 동작 확인

✅ **iPad**
- [ ] Safari 접속 테스트
- [ ] 홈 화면 추가 테스트
- [ ] Split View 동작 확인

---

## 💡 개발 팁

### 로컬 테스트 시:

```javascript
// 버전 강제 변경
localStorage.setItem('app_version', '0.0.0');

// 새로고침
location.reload();

// 결과: 자동으로 현재 버전으로 업데이트
```

### 버전 로그 확인:

```javascript
// Console에 항상 출력됨
"Current version: 1.1.2"
"Stored version: 1.1.1"
"Version changed! Forcing reload..."
```

---

## 📚 참고 자료

- [Apple PWA Guidelines](https://developer.apple.com/documentation/webkit/safari_web_extensions)
- [iOS Safari Limitations](https://firt.dev/notes/pwa-ios/)
- [Service Worker Cookbook](https://serviceworke.rs/)

---

**마지막 업데이트:** 2025-10-28  
**테스트 완료:** iOS 16+, iPadOS 16+  
**현재 버전:** 1.1.2
