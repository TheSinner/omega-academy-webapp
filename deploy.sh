#!/bin/bash

# 오메가수학전문학원 배포 스크립트
# 사용법: ./deploy.sh [local|production]

set -e

echo "🚀 오메가수학전문학원 배포 스크립트"
echo "======================================"

# 파라미터 확인
ENVIRONMENT=${1:-local}

if [ "$ENVIRONMENT" == "local" ]; then
    echo "📍 로컬 개발 환경 배포"
    echo ""
    
    # 로컬 데이터베이스 마이그레이션
    echo "1️⃣ 로컬 데이터베이스 마이그레이션 적용..."
    npm run db:migrate:local
    
    # 빌드
    echo "2️⃣ 프로젝트 빌드 중..."
    npm run build
    
    # 개발 서버 실행
    echo "3️⃣ 개발 서버 시작..."
    echo "   → http://localhost:3000"
    npm run dev:d1
    
elif [ "$ENVIRONMENT" == "production" ]; then
    echo "☁️  프로덕션 배포"
    echo ""
    
    # Wrangler 로그인 확인
    echo "1️⃣ Cloudflare 인증 확인 중..."
    if ! npx wrangler whoami > /dev/null 2>&1; then
        echo "❌ Cloudflare 로그인이 필요합니다."
        echo "   실행: npx wrangler login"
        exit 1
    fi
    
    echo "✅ 인증 완료"
    echo ""
    
    # 프로덕션 데이터베이스 마이그레이션
    echo "2️⃣ 프로덕션 데이터베이스 마이그레이션..."
    read -p "   데이터베이스 마이그레이션을 적용하시겠습니까? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        npx wrangler d1 migrations apply omega-academy-db --remote
    else
        echo "   ⏭️  마이그레이션 건너뜀"
    fi
    echo ""
    
    # 빌드
    echo "3️⃣ 프로젝트 빌드 중..."
    npm run build
    echo ""
    
    # 배포
    echo "4️⃣ Cloudflare Pages 배포 중..."
    npx wrangler pages deploy dist --project-name omega-academy
    echo ""
    
    echo "✅ 배포 완료!"
    echo "   → https://omega-academy.pages.dev"
    
else
    echo "❌ 잘못된 환경: $ENVIRONMENT"
    echo ""
    echo "사용법:"
    echo "  ./deploy.sh local       # 로컬 개발 서버"
    echo "  ./deploy.sh production  # 프로덕션 배포"
    exit 1
fi
