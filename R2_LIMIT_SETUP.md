# R2 Storage 비용 상한 설정 가이드

## ⚠️ 중요: R2는 무료 한도 초과 시 과금 발생 가능!

무료 한도: **10GB 저장 / 월 100만 요청**

## 🛡️ 방법 1: Lifecycle Policy (자동 삭제)

### 설정 방법:
1. Cloudflare Dashboard 접속
2. **R2** → **omega-academy-images** 버킷 선택
3. **Settings** 탭 → **Lifecycle rules** 섹션
4. **Add rule** 클릭

### 추천 설정:

```
Rule Name: auto-delete-old-files
Action: Delete objects
Days: 90

설명: 90일 지난 이미지 자동 삭제
```

**효과:**
- 오래된 이미지 자동 정리
- 스토리지 10GB 이하 유지
- 비용 폭발 방지

## 🛡️ 방법 2: Storage Limit (용량 제한)

현재 Cloudflare는 **버킷별 용량 하드 리미트를 직접 설정할 수 없습니다.**

하지만 **애플리케이션 레벨에서 제한** 가능:

### 구현 방법:

```typescript
// src/middleware/storageLimit.ts
export async function checkStorageLimit(c: Context) {
  // R2 총 사용량 확인
  const list = await c.env.IMAGES.list();
  let totalSize = 0;
  
  for (const object of list.objects) {
    totalSize += object.size;
  }
  
  const limitGB = 8; // 10GB 한도 중 안전 마진 2GB
  const limitBytes = limitGB * 1024 * 1024 * 1024;
  
  if (totalSize > limitBytes) {
    return c.json({
      error: '스토리지 용량 초과. 관리자에게 문의하세요.',
      currentSize: `${(totalSize / 1024 / 1024 / 1024).toFixed(2)}GB`,
      limit: `${limitGB}GB`
    }, 507); // Insufficient Storage
  }
}
```

**주의:** R2 list() 작업도 비용이 발생하므로, 캐싱과 함께 사용해야 합니다.

## 🛡️ 방법 3: 신용카드 제한 (최종 방어선)

### Virtual Card 사용 (가장 안전!)

1. **토스뱅크/카카오뱅크 가상카드 발급**
   - 월 한도: **$10 (약 13,000원)**
   - 한도 초과 시: 자동 결제 거부

2. Cloudflare에 가상카드 등록
   - Settings → Billing → Payment Methods
   - 가상카드 등록

3. **효과:**
   - 물리적으로 $10 이상 결제 불가능
   - 보안 뚫려도 최대 손실 $10

## 📊 각 방법 비교

| 방법 | 효과 | 안전도 | 단점 |
|-----|------|--------|------|
| **무료 플랜 유지** | 무료 한도 초과 시 서비스 중단 | ⭐⭐⭐⭐⭐ | 서비스 중단 가능 |
| **Lifecycle Policy** | 자동 정리로 용량 유지 | ⭐⭐⭐⭐ | 90일 이후 이미지 삭제 |
| **가상카드 한도** | 물리적 결제 차단 | ⭐⭐⭐⭐⭐ | 카드 발급 필요 |
| **앱 레벨 제한** | 업로드 차단 | ⭐⭐⭐ | 코드 우회 가능 |

## ✅ 추천 조합

**최강의 방어:**
```
1. 무료 플랜 유지 (Workers 유료 전환 금지)
2. R2 Lifecycle 90일 설정
3. 가상카드 월 $10 한도 설정
4. Cloudflare 알림 $5 설정
```

이렇게 하면:
- 보안 뚫려도 최대 $10 손실
- 대부분 무료 한도 내 운영
- 이상 징후 즉시 알림

## 🚨 긴급 상황 대응

비용이 급증하는 경우:

1. **즉시 Workers 비활성화**
   ```bash
   wrangler pages deployment list --project-name omega-academy
   wrangler pages deployment delete <deployment-id> --project-name omega-academy
   ```

2. **R2 버킷 비우기**
   ```bash
   # 모든 이미지 삭제
   wrangler r2 object delete omega-academy-images --all
   ```

3. **D1 Database 중단**
   ```bash
   # wrangler.jsonc에서 d1_databases 섹션 주석 처리
   ```

4. **최후의 수단: 프로젝트 삭제**
   - Cloudflare Dashboard → Pages → omega-academy → Delete

## 💡 참고

**Cloudflare 무료 플랜의 장점:**
- 한도 초과 시 **자동 과금 없음**
- 서비스만 중단되고 **청구서 날아오지 않음**
- Workers/Pages는 완전 무료 (요청 수 제한만 있음)

**위험한 부분:**
- R2 Storage (10GB 초과 시 GB당 $0.015)
- D1 Database (읽기 초과 시 100만 건당 $0.001)

하지만 현재 적용된 **Rate Limiting + 이미지 크기 제한**으로
정상적으로는 무료 한도 초과 불가능합니다!
