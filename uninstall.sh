#!/bin/bash
# 이미지 인쇄 확장 기능 제거 스크립트
# 지원: Nautilus (GNOME), Thunar (XFCE)

echo "=== 이미지 인쇄 확장 기능 제거 ==="
echo ""

REMOVED_COUNT=0

# ================================
# Nautilus 제거
# ================================
echo "📦 Nautilus 확장 제거 중..."

if [ -f ~/.local/share/nautilus/scripts/.hidden/인쇄 ]; then
    rm ~/.local/share/nautilus/scripts/.hidden/인쇄
    echo "  ✓ 인쇄 스크립트 제거 완료"
    ((REMOVED_COUNT++))
else
    echo "  ⚠ 인쇄 스크립트가 설치되어 있지 않습니다."
fi

if [ -f ~/.local/share/nautilus-python/extensions/quick_print.py ]; then
    rm ~/.local/share/nautilus-python/extensions/quick_print.py
    echo "  ✓ Nautilus Python 확장 제거 완료"
    ((REMOVED_COUNT++))
else
    echo "  ⚠ Nautilus Python 확장이 설치되어 있지 않습니다."
fi

# ================================
# Thunar 제거
# ================================
echo ""
echo "📦 Thunar 확장 제거 중..."

if [ -f ~/.local/bin/thunar-image-print ]; then
    rm ~/.local/bin/thunar-image-print
    echo "  ✓ Thunar 래퍼 스크립트 제거 완료"
    ((REMOVED_COUNT++))
else
    echo "  ⚠ Thunar 래퍼 스크립트가 설치되어 있지 않습니다."
fi

# Thunar 커스텀 액션 제거
UCA_FILE=~/.config/Thunar/uca.xml
if [ -f "$UCA_FILE" ]; then
    if grep -q "thunar-image-print" "$UCA_FILE"; then
        # 백업 생성
        cp "$UCA_FILE" "$UCA_FILE.backup.$(date +%Y%m%d_%H%M%S)"

        # unique-id가 1729527123456789-1인 액션 제거
        # <action>부터 </action>까지 제거
        sed -i '/<unique-id>1729527123456789-1<\/unique-id>/,/<\/action>/d' "$UCA_FILE"

        echo "  ✓ Thunar 커스텀 액션 제거 완료"
        echo "  📝 원본 파일은 $UCA_FILE.backup.* 에 백업되었습니다."
        ((REMOVED_COUNT++))
    else
        echo "  ⚠ Thunar 커스텀 액션이 등록되어 있지 않습니다."
    fi
else
    echo "  ⚠ Thunar 설정 파일이 없습니다."
fi

# ================================
# 완료 메시지
# ================================
echo ""
echo "========================================="

if [ $REMOVED_COUNT -gt 0 ]; then
    echo "✅ 제거가 완료되었습니다! ($REMOVED_COUNT개 항목)"
    echo "========================================="
    echo ""
    echo "🔄 파일 매니저를 재시작하세요:"

    if command -v nautilus &> /dev/null; then
        echo "   $ nautilus -q"
    fi

    if command -v thunar &> /dev/null; then
        echo "   $ thunar -q"
    fi
else
    echo "⚠️  제거할 항목이 없습니다."
    echo "========================================="
    echo ""
    echo "이미지 인쇄 확장 기능이 설치되어 있지 않습니다."
fi

echo ""
