# 🔍 iOS 디버깅 완벽 가이드

## 🍎 현재 적용된 iOS 캐시 해결책

### 강화된 3단계 방어선

#### 1단계: 버전 체크 (LocalStorage)
```javascript
저장된 버전 vs 현재 버전 비교
    ↓
다르면 → 강제 업데이트 프로세스 시작
```

#### 2단계: 캐시 완전 삭제
```javascript
// 모든 Cache API 캐시 삭제
caches.keys().then(names => {
  names.forEach(name => caches.delete(name));
});

// Service Worker 등록 해제
navigator.serviceWorker.getRegistrations().then(regs => {
  regs.forEach(reg => reg.unregister());
});
```

#### 3단계: 강제 리다이렉트
```javascript
// 완전히 새로운 URL로 강제 이동
window.location.replace(url + '?v=1.1.3&t=' + Date.now());
```

---

## 📱 iPad에서 실제 디버깅 방법

### 필수 준비물:
- iPad (테스트 기기)
- Mac (Safari 개발자 도구용)
- Lightning/USB-C 케이블

### 1️⃣ iPad 설정

```
iPad 설정
    ↓
Safari
    ↓
고급
    ↓
✅ 웹 속성 표시 ON
```

### 2️⃣ Mac에서 Safari 개발자 도구 활성화

```
Mac Safari → 설정 → 고급
    ↓
✅ 메뉴 막대에서 개발자용 메뉴 보기 ON
```

### 3️⃣ iPad 연결 및 디버깅

```
1. iPad를 Mac에 USB 연결
2. iPad에서 Safari로 사이트 접속
3. Mac Safari → 개발 메뉴 → [iPad 이름]
4. → omega-academy.pages.dev 선택
5. 개발자 도구 창 열림!
```

---

## 🔍 실시간 로그 확인

### Console에서 보여야 할 로그:

```javascript
[app.js] Loaded at: 2025-10-28T10:30:45.123Z
[Version Check] Current: 1.1.3
[Version Check] Platform: iOS
[Version Check] Standalone: true  // 홈 화면 앱인 경우
[Version Check] Stored: 1.1.2     // 이전 버전
[Version Check] Version mismatch! Forcing update...
// → 0.5초 후 페이지 리다이렉트
```

### 버전이 같을 때:
```javascript
[app.js] Loaded at: 2025-10-28T10:30:45.123Z
[Version Check] Current: 1.1.3
[Version Check] Platform: iOS
[Version Check] Standalone: true
[Version Check] Stored: 1.1.3
[Version Check] Version OK
```

---

## 🧪 테스트 시나리오

### 시나리오 1: 버전 변경 시뮬레이션

**iPad Console에서 실행:**
```javascript
// 1. 현재 버전 확인
localStorage.getItem('omega_app_version');
// 출력: "1.1.3"

// 2. 이전 버전으로 변경
localStorage.setItem('omega_app_version', '1.1.2');

// 3. 새로고침
location.reload();

// 예상 결과:
// - "[Version Check] Version mismatch! Forcing update..." 로그
// - 0.5초 후 자동으로 페이지 리다이렉트
// - URL에 ?v=1.1.3&t=xxxxx 파라미터 추가됨
// - 최신 버전 로드 완료
```

### 시나리오 2: 캐시 확인

**iPad Console에서 실행:**
```javascript
// 캐시 목록 확인
caches.keys().then(keys => console.log('Caches:', keys));

// Service Worker 상태 확인
navigator.serviceWorker.getRegistrations()
  .then(regs => console.log('SW Registrations:', regs.length));
```

### 시나리오 3: 강제 캐시 삭제

**iPad Console에서 실행:**
```javascript
// 모든 캐시 삭제
caches.keys().then(keys => {
  keys.forEach(key => caches.delete(key));
  console.log('All caches deleted');
});

// Service Worker 삭제
navigator.serviceWorker.getRegistrations().then(regs => {
  regs.forEach(reg => reg.unregister());
  console.log('All SW unregistered');
});

// LocalStorage 삭제
localStorage.removeItem('omega_app_version');

// 새로고침
location.reload();
```

---

## ⚠️ 일반적인 문제들

### 문제 1: "여전히 구버전이 보여요"

**체크리스트:**

```javascript
// Console에서 차례로 확인:

// 1. 현재 HTML 버전 확인
console.log('Check meta tags...');
document.querySelector('link[href*="app.js"]').href;
// 예상: "/static/app.js?v=1.1.3"

// 2. LocalStorage 버전 확인
localStorage.getItem('omega_app_version');
// 예상: "1.1.3"

// 3. app.js 로드 확인
// Console에 "[app.js] Loaded at: ..." 메시지가 있어야 함

// 4. 버전 체크 로그 확인
// "[Version Check] ..." 시리즈 로그가 있어야 함
```

**해결 방법:**
```javascript
// 완전 초기화
localStorage.clear();
sessionStorage.clear();
caches.keys().then(keys => keys.forEach(k => caches.delete(k)));
navigator.serviceWorker.getRegistrations()
  .then(regs => regs.forEach(r => r.unregister()));

// 5초 후 새로고침
setTimeout(() => location.reload(), 5000);
```

### 문제 2: "무한 새로고침이 발생해요"

**원인:** sessionStorage의 RELOAD_KEY가 제대로 처리 안됨

**해결:**
```javascript
sessionStorage.removeItem('omega_force_reload');
location.reload();
```

### 문제 3: "홈 화면 앱에서만 안돼요"

**원인:** 홈 화면 앱은 완전히 독립된 컨텍스트

**해결:**
```
1. 홈 화면에서 앱 아이콘 길게 누르기
2. "앱 제거" 선택
3. Safari로 사이트 다시 방문
4. 공유 → 홈 화면에 추가
5. 새로 설치된 앱 실행
```

---

## 📊 버전 배포 체크리스트

### 배포 전:

```
✅ src/index.tsx의 APP_VERSION 변경
✅ public/sw.js의 CACHE_VERSION 변경
✅ 두 버전이 같은지 확인
✅ npm run build 실행
```

### 배포 후:

```
✅ Windows Chrome에서 테스트
✅ Android Chrome에서 테스트
✅ iPad Safari에서 테스트
✅ iPad 홈 화면 앱에서 테스트
```

### iPad 테스트 상세:

```
1. iPad Safari 접속
    ↓
2. Mac Safari 개발자 도구 연결
    ↓
3. Console 로그 확인:
   - [app.js] Loaded at: ...
   - [Version Check] Current: 1.1.3
   - [Version Check] Stored: 1.1.3
   - [Version Check] Version OK
    ↓
4. 기능 테스트 (로그인, 질문 작성 등)
    ↓
5. ✅ 통과!
```

---

## 🔧 고급 디버깅

### Network 탭에서 확인:

```
Mac Safari 개발자 도구 → Network 탭
    ↓
iPad에서 페이지 새로고침
    ↓
확인 사항:
✅ index (HTML) - 200 OK
✅ app.js?v=1.1.3 - 200 OK (304 아님!)
✅ sw.js?v=1.1.3 - 200 OK
✅ manifest.json?v=1.1.3 - 200 OK
```

### 캐시가 남아있는 경우:
```
app.js?v=1.1.3 - 304 Not Modified  ← 문제!
```

**해결:**
```javascript
// Console에서 강제 캐시 삭제 후 재시도
caches.keys().then(keys => {
  keys.forEach(key => caches.delete(key));
});
location.reload();
```

---

## 💡 왜 iOS는 이렇게 복잡한가요?

### iOS Safari의 특징:

1. **매우 공격적인 캐싱**
   - 성능을 위해 캐시를 최대한 활용
   - no-cache 헤더를 종종 무시

2. **Service Worker 제한**
   - 백그라운드 동작 제한
   - 홈 화면 앱에서 더욱 제한적

3. **홈 화면 앱 = 독립 앱**
   - Safari와 완전히 별도
   - 캐시, 쿠키, Storage 모두 독립

4. **보안 정책**
   - iframe, popup 등 제한
   - 일부 Web API 미지원

### 우리의 해결책:

```
버전 체크 (LocalStorage)
    +
캐시 강제 삭제 (Cache API)
    +
SW 등록 해제
    +
타임스탬프 URL 리다이렉트
    =
✨ 완벽한 캐시 무효화!
```

---

## 🎯 최종 확인 스크립트

**iPad Console에 복사 붙여넣기:**

```javascript
(async function diagnose() {
  console.log('=== iOS Cache Diagnostic ===');
  
  // 1. 버전 확인
  const version = localStorage.getItem('omega_app_version');
  console.log('1. Stored Version:', version);
  
  // 2. 플랫폼 확인
  const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
  console.log('2. Is iOS:', isIOS);
  
  // 3. 홈 화면 앱 확인
  const isStandalone = window.navigator.standalone || 
    window.matchMedia('(display-mode: standalone)').matches;
  console.log('3. Is Standalone App:', isStandalone);
  
  // 4. 캐시 확인
  const cacheKeys = await caches.keys();
  console.log('4. Cache Keys:', cacheKeys);
  
  // 5. Service Worker 확인
  const registrations = await navigator.serviceWorker.getRegistrations();
  console.log('5. SW Registrations:', registrations.length);
  
  // 6. 현재 URL 파라미터 확인
  console.log('6. URL Params:', window.location.search);
  
  console.log('=== Diagnostic Complete ===');
})();
```

---

**현재 버전:** 1.1.3  
**마지막 업데이트:** 2025-10-28  
**테스트 완료:** iOS 16+, iPadOS 16+
