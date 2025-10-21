#!/bin/bash
# 이미지 인쇄 확장 기능 설치 스크립트
# 지원: Nautilus (GNOME), Thunar (XFCE)

echo "=== 이미지 인쇄 확장 기능 설치 ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_NAUTILUS=false
INSTALL_THUNAR=false

# 파일 매니저 감지
echo "[감지] 설치된 파일 매니저 확인 중..."

if command -v nautilus &> /dev/null; then
    echo "✓ Nautilus (GNOME) 감지됨"
    INSTALL_NAUTILUS=true
fi

if command -v thunar &> /dev/null; then
    echo "✓ Thunar (XFCE) 감지됨"
    INSTALL_THUNAR=true
fi

if [ "$INSTALL_NAUTILUS" = false ] && [ "$INSTALL_THUNAR" = false ]; then
    echo "❌ Nautilus 또는 Thunar 파일 매니저를 찾을 수 없습니다."
    echo "   지원하는 파일 매니저를 설치한 후 다시 시도하세요."
    exit 1
fi

echo ""

# ================================
# Nautilus 설치
# ================================
if [ "$INSTALL_NAUTILUS" = true ]; then
    echo "=== Nautilus 확장 설치 ==="

    # Python-Nautilus 패키지 설치
    echo "[1/4] Python-Nautilus 패키지 설치 중..."
    if ! dpkg -l | grep -q python3-nautilus; then
        echo "python3-nautilus 설치가 필요합니다."
        echo "다음 명령어를 실행하세요:"
        echo "  sudo apt install -y python3-nautilus"
        echo ""
        read -p "지금 설치하시겠습니까? (y/n): " answer
        if [ "$answer" = "y" ]; then
            sudo apt install -y python3-nautilus
        else
            echo "Nautilus 설치를 건너뜁니다."
            INSTALL_NAUTILUS=false
        fi
    else
        echo "✓ python3-nautilus가 이미 설치되어 있습니다."
    fi

    if [ "$INSTALL_NAUTILUS" = true ]; then
        # 디렉토리 생성
        echo ""
        echo "[2/4] Nautilus 디렉토리 구조 생성 중..."
        mkdir -p ~/.local/share/nautilus/scripts/.hidden
        mkdir -p ~/.local/share/nautilus-python/extensions/
        echo "✓ 디렉토리 생성 완료"

        # 인쇄 스크립트 복사
        echo ""
        echo "[3/4] 인쇄 스크립트 설치 중..."
        cp "$SCRIPT_DIR/인쇄" ~/.local/share/nautilus/scripts/.hidden/
        chmod +x ~/.local/share/nautilus/scripts/.hidden/인쇄
        echo "✓ 인쇄 스크립트 설치 완료"

        # Nautilus 확장 기능 복사
        echo ""
        echo "[4/4] Nautilus 확장 기능 설치 중..."
        cp "$SCRIPT_DIR/quick_print.py" ~/.local/share/nautilus-python/extensions/
        chmod +x ~/.local/share/nautilus-python/extensions/quick_print.py
        echo "✓ Nautilus 확장 기능 설치 완료"
    fi

    echo ""
fi

# ================================
# Thunar 설치
# ================================
if [ "$INSTALL_THUNAR" = true ]; then
    echo "=== Thunar 확장 설치 ==="

    # 공통 스크립트가 아직 설치되지 않았다면 설치
    if [ ! -f ~/.local/share/nautilus/scripts/.hidden/인쇄 ]; then
        echo "[1/3] 디렉토리 구조 생성 중..."
        mkdir -p ~/.local/share/nautilus/scripts/.hidden
        echo "✓ 디렉토리 생성 완료"

        echo ""
        echo "[2/3] 인쇄 스크립트 설치 중..."
        cp "$SCRIPT_DIR/인쇄" ~/.local/share/nautilus/scripts/.hidden/
        chmod +x ~/.local/share/nautilus/scripts/.hidden/인쇄
        echo "✓ 인쇄 스크립트 설치 완료"
    else
        echo "[1/3] 인쇄 스크립트가 이미 설치되어 있습니다."
    fi

    # Thunar 래퍼 스크립트 설치
    echo ""
    echo "[2/3] Thunar 래퍼 스크립트 설치 중..."
    mkdir -p ~/.local/bin
    cp "$SCRIPT_DIR/thunar-image-print" ~/.local/bin/
    chmod +x ~/.local/bin/thunar-image-print
    echo "✓ Thunar 래퍼 스크립트 설치 완료"

    # Thunar 커스텀 액션 추가
    echo ""
    echo "[3/3] Thunar 커스텀 액션 추가 중..."
    mkdir -p ~/.config/Thunar

    UCA_FILE=~/.config/Thunar/uca.xml

    if [ ! -f "$UCA_FILE" ]; then
        # uca.xml 파일이 없으면 새로 생성
        echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$UCA_FILE"
        echo "<actions>" >> "$UCA_FILE"
        cat "$SCRIPT_DIR/thunar-custom-action.xml" | grep -v "<?xml" | grep -v "<actions>" | grep -v "</actions>" >> "$UCA_FILE"
        echo "</actions>" >> "$UCA_FILE"
        echo "✓ Thunar 커스텀 액션 생성 완료"
    else
        # 기존 파일이 있으면 병합 (중복 확인)
        if grep -q "thunar-image-print" "$UCA_FILE"; then
            echo "⚠ 이미지 인쇄 액션이 이미 등록되어 있습니다."
        else
            # </actions> 태그 바로 전에 새 액션 삽입
            cp "$UCA_FILE" "$UCA_FILE.backup"
            sed -i '/<\/actions>/i\<action>\n\t<icon>printer<\/icon>\n\t<name>이미지 인쇄<\/name>\n\t<submenu><\/submenu>\n\t<unique-id>1729527123456789-1<\/unique-id>\n\t<command>~\/.local\/bin\/thunar-image-print %F<\/command>\n\t<description>고급 옵션으로 이미지 파일 인쇄<\/description>\n\t<patterns>*.jpg;*.jpeg;*.png;*.gif;*.bmp;*.tiff;*.tif;*.webp;*.svg;*.ico<\/patterns>\n\t<startup-notify\/>\n\t<image-files\/>\n<\/action>' "$UCA_FILE"
            echo "✓ Thunar 커스텀 액션 추가 완료"
        fi
    fi

    echo ""
fi

# ================================
# 설치 완료
# ================================
echo ""
echo "========================================="
echo "✅ 설치가 완료되었습니다!"
echo "========================================="
echo ""

if [ "$INSTALL_NAUTILUS" = true ]; then
    echo "📦 Nautilus (GNOME):"
    echo "   파일 매니저를 재시작하려면:"
    echo "   $ nautilus -q"
    echo ""
fi

if [ "$INSTALL_THUNAR" = true ]; then
    echo "📦 Thunar (XFCE):"
    echo "   파일 매니저를 재시작하려면:"
    echo "   $ thunar -q"
    echo ""
fi

echo "🖼️  사용 방법:"
echo "   이미지 파일에 우클릭 → '인쇄' 메뉴 선택"
echo ""
