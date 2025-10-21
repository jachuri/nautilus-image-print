# 🖨️ 이미지 인쇄 확장 - Nautilus & Thunar

> **GNOME + XFCE 지원** - 이미지 파일 우클릭으로 고급 인쇄 옵션 제공

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Ubuntu](https://img.shields.io/badge/ubuntu-24.04%20LTS-orange.svg)
![Python](https://img.shields.io/badge/python-3.12-blue.svg)
![GNOME](https://img.shields.io/badge/GNOME-Nautilus-green.svg)
![XFCE](https://img.shields.io/badge/XFCE-Thunar-blue.svg)

## 🐧 지원 플랫폼

### ✅ 완전 지원
- **Ubuntu 24.04 LTS** (권장)
  - GNOME + Nautilus
  - XFCE + Thunar
- **Ubuntu 22.04 LTS** (테스트됨)
  - GNOME + Nautilus
  - XFCE + Thunar

### ⚠️ 부분 지원
- **다른 배포판**: GNOME 또는 XFCE 환경이면 작동 가능하나 테스트되지 않음
  - Fedora (GNOME/XFCE)
  - Debian (GNOME/XFCE)
  - Xubuntu (XFCE)
  - Linux Mint (GNOME/XFCE)
  - 기타 GNOME 또는 XFCE 기반 배포판

### ❌ 미지원
- **KDE Plasma**: Dolphin 파일 매니저 (별도 구현 필요)
- **MATE/Cinnamon**: Caja/Nemo 파일 매니저 (별도 구현 필요)

## ✨ 기능

### 📐 고급 인쇄 옵션
- **크기 조절**
  - 꽉 차게 (Fit to Page)
  - 실제 크기 (100%)
  - 축소만 (Shrink to Fit)
  - 사용자 정의 (10-500%)

- **페이지 방향**
  - 세로 (Portrait)
  - 가로 (Landscape)

- **정렬**
  - 가운데, 좌상단, 우상단, 좌하단, 우하단

- **여백 설정**
  - 여백 없음
  - 기본 여백
  - 사용자 정의 (mm 단위)

- **고급 옵션**
  - 가로세로 비율 유지
  - 회전 (자동/0°/90°/180°/270°)
  - DPI 설정 (150/300/600)

### 🚀 편의 기능
- ✅ 우클릭 메뉴 직접 통합
- ✅ 여러 파일 선택 시 각각 별도 페이지로 인쇄
- ✅ 이미지 파일만 메뉴 표시
- ✅ 한글 UI
- ✅ GNOME과 XFCE 동시 지원

## 📦 설치

### 🎯 자동 설치 (권장)

원라이너 설치:
```bash
curl -fsSL https://raw.githubusercontent.com/jachuri/nautilus-image-print/master/install.sh | bash
```

또는 수동 설치:
```bash
# 저장소 클론
git clone https://github.com/jachuri/nautilus-image-print.git
cd nautilus-image-print

# 설치 실행 (Nautilus와 Thunar를 자동 감지)
./install.sh
```

설치 스크립트는 자동으로:
- 설치된 파일 매니저 감지 (Nautilus, Thunar)
- 필요한 패키지 설치 안내
- 해당 파일 매니저에 맞게 설치

### 📋 수동 설치

#### Nautilus (GNOME)
```bash
# Python-Nautilus 설치
sudo apt install -y python3-nautilus

# 디렉토리 생성
mkdir -p ~/.local/share/nautilus/scripts/.hidden
mkdir -p ~/.local/share/nautilus-python/extensions/

# 파일 복사
cp 인쇄 ~/.local/share/nautilus/scripts/.hidden/
cp quick_print.py ~/.local/share/nautilus-python/extensions/

# 실행 권한 부여
chmod +x ~/.local/share/nautilus/scripts/.hidden/인쇄
chmod +x ~/.local/share/nautilus-python/extensions/quick_print.py

# Nautilus 재시작
nautilus -q
```

#### Thunar (XFCE)
```bash
# 디렉토리 생성
mkdir -p ~/.local/share/nautilus/scripts/.hidden
mkdir -p ~/.local/bin
mkdir -p ~/.config/Thunar

# 파일 복사
cp 인쇄 ~/.local/share/nautilus/scripts/.hidden/
cp thunar-image-print ~/.local/bin/

# 실행 권한 부여
chmod +x ~/.local/share/nautilus/scripts/.hidden/인쇄
chmod +x ~/.local/bin/thunar-image-print

# Thunar 커스텀 액션 추가
# 방법 1: Thunar 설정에서 수동으로 추가
#   편집 → 사용자 지정 동작 구성 → + 버튼
#   이름: 이미지 인쇄
#   명령: ~/.local/bin/thunar-image-print %F
#   파일 패턴: *.jpg;*.jpeg;*.png;*.gif;*.bmp;*.tiff;*.webp;*.svg
#   조건: 이미지 파일 (Image Files)

# 방법 2: 설치 스크립트로 자동 추가
./install.sh
```

## 🔧 요구사항

### GNOME (Nautilus)
- **파일 매니저**: Nautilus 46.x
- **Python**: 3.12 이상
- **필수 패키지**: `python3-nautilus`

### XFCE (Thunar)
- **파일 매니저**: Thunar 4.x
- **Python**: 3.12 이상
- **필수 패키지**: GTK 3.0

### 공통
- CUPS 프린터 시스템
- GTK 3.0 (보통 기본 설치됨)

## 📖 사용 방법

1. 파일 매니저에서 이미지 파일 선택
2. **우클릭 → 이미지 인쇄** (또는 **인쇄**)
3. "이미지 설정" 탭에서 옵션 조절
4. 인쇄!

## 🗂️ 파일 구조

```
nautilus-image-print/
├── install.sh                    # 통합 설치 스크립트
├── uninstall.sh                  # 제거 스크립트
├── 인쇄                          # 메인 인쇄 스크립트 (GTK3 Python)
├── quick_print.py                # Nautilus Python 확장
├── thunar-image-print            # Thunar 래퍼 스크립트
├── thunar-custom-action.xml      # Thunar 커스텀 액션 정의
└── README.md                     # 문서
```

## 🔄 업데이트

```bash
cd nautilus-image-print
git pull
./install.sh
```

## ❌ 제거

### 자동 제거 (권장)
```bash
./uninstall.sh
```

### 수동 제거

#### Nautilus
```bash
rm ~/.local/share/nautilus/scripts/.hidden/인쇄
rm ~/.local/share/nautilus-python/extensions/quick_print.py
nautilus -q
```

#### Thunar
```bash
rm ~/.local/bin/thunar-image-print
# Thunar 설정에서 "이미지 인쇄" 액션 수동 삭제
# 편집 → 사용자 지정 동작 구성 → 이미지 인쇄 선택 후 - 버튼
thunar -q
```

#### 공통 스크립트
```bash
rm ~/.local/share/nautilus/scripts/.hidden/인쇄
```

## 🐛 문제 해결

### Nautilus에서 메뉴가 보이지 않아요
```bash
# Nautilus 재시작
nautilus -q

# python3-nautilus 재설치
sudo apt install --reinstall python3-nautilus
```

### Thunar에서 메뉴가 보이지 않아요
```bash
# Thunar 재시작
thunar -q

# 커스텀 액션 확인
# Thunar → 편집 → 사용자 지정 동작 구성
# "이미지 인쇄" 액션이 있는지 확인
```

### 인쇄 대화상자가 열리지 않아요
```bash
# 로그 확인
cat /tmp/nautilus_print_python.log

# 스크립트 권한 확인
ls -l ~/.local/share/nautilus/scripts/.hidden/인쇄
ls -l ~/.local/bin/thunar-image-print

# 실행 권한이 없으면
chmod +x ~/.local/share/nautilus/scripts/.hidden/인쇄
chmod +x ~/.local/bin/thunar-image-print
```

### GTK 관련 오류가 발생해요
```bash
# GTK 3.0 설치 확인
python3 -c "from gi.repository import Gtk; print(Gtk._version)"

# GTK가 없으면 설치
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0
```

## 💡 작동 원리

### Nautilus (GNOME)
1. **Python-Nautilus**: Nautilus 확장 API를 사용하여 우클릭 메뉴에 "인쇄" 항목 추가
2. **환경변수 전달**: `NAUTILUS_SCRIPT_SELECTED_FILE_PATHS`로 선택된 파일 경로 전달
3. **GTK PrintOperation**: GTK의 네이티브 인쇄 대화상자 사용
4. **커스텀 탭**: 이미지 전용 설정을 위한 커스텀 탭 추가

### Thunar (XFCE)
1. **Custom Actions**: Thunar의 커스텀 액션 시스템 활용
2. **래퍼 스크립트**: Thunar 환경변수 (%F)를 Nautilus 형식으로 변환
3. **공통 스크립트**: Nautilus와 동일한 인쇄 스크립트 사용
4. **GTK PrintOperation**: 동일한 GTK 인쇄 대화상자

### 아키텍처
```
사용자 우클릭
    ↓
┌─────────────┬─────────────┐
│  Nautilus   │   Thunar    │
│quick_print  │thunar-image │
│    .py      │  -print     │
└─────────────┴─────────────┘
    ↓               ↓
    └───────┬───────┘
            ↓
    공통 인쇄 스크립트 (인쇄)
            ↓
    GTK PrintOperation
            ↓
       CUPS 프린터
```

## ⚠️ 제한사항

- **GNOME/XFCE 전용**: KDE, MATE 등 다른 데스크톱 환경에서는 작동하지 않습니다
- **파일 매니저 의존성**: Dolphin, Caja, Nemo 등은 지원하지 않습니다
- **Python 3.12+**: 이전 버전의 Python에서는 테스트되지 않았습니다

## 🤝 기여

이슈와 풀 리퀘스트를 환영합니다!

특히 다음 기여를 환영합니다:
- 다른 배포판 테스트 결과
- 다른 파일 매니저 지원 (KDE Dolphin, MATE Caja 등)
- 번역 (영문, 일문 등)
- 버그 리포트
- 기능 제안

## 📄 라이선스

MIT License

## 🙏 감사

- GTK Team
- GNOME Nautilus Team
- XFCE Thunar Team
- Python-Nautilus Contributors
- Ubuntu Community

---

**업데이트**: 2025-10-21 - XFCE Thunar 지원 추가
**제작일**: 2025-10-05
**플랫폼**: Ubuntu 24.04 LTS / GNOME 46 / XFCE
**제작자**: [@jachuri](https://github.com/jachuri)
**레포지토리**: https://github.com/jachuri/nautilus-image-print
