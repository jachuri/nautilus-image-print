#!/bin/bash
# Nautilus 이미지 인쇄 확장 기능 설치 스크립트

echo "=== Nautilus 이미지 인쇄 확장 기능 설치 ==="
echo ""

# 1. Python-Nautilus 패키지 설치
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
        echo "설치가 취소되었습니다. 나중에 수동으로 설치하세요."
        exit 1
    fi
else
    echo "✓ python3-nautilus가 이미 설치되어 있습니다."
fi

# 2. 디렉토리 생성
echo ""
echo "[2/4] 디렉토리 구조 생성 중..."
mkdir -p ~/.local/share/nautilus/scripts/.hidden
mkdir -p ~/.local/share/nautilus-python/extensions/
echo "✓ 디렉토리 생성 완료"

# 3. 인쇄 스크립트 복사
echo ""
echo "[3/4] 인쇄 스크립트 설치 중..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/인쇄" ~/.local/share/nautilus/scripts/.hidden/
chmod +x ~/.local/share/nautilus/scripts/.hidden/인쇄
echo "✓ 인쇄 스크립트 설치 완료"

# 4. Nautilus 확장 기능 복사
echo ""
echo "[4/4] Nautilus 확장 기능 설치 중..."
cp "$SCRIPT_DIR/quick_print.py" ~/.local/share/nautilus-python/extensions/
chmod +x ~/.local/share/nautilus-python/extensions/quick_print.py
echo "✓ 확장 기능 설치 완료"

# 5. Nautilus 재시작
echo ""
echo "설치가 완료되었습니다!"
echo ""
echo "Nautilus를 재시작하려면 다음 명령어를 실행하세요:"
echo "  nautilus -q"
echo ""
echo "이미지 파일에 우클릭하면 '인쇄' 메뉴가 나타납니다."
