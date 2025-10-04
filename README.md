# 🖨️ Nautilus Image Print Extension for Ubuntu

> **Ubuntu/GNOME 전용** - 이미지 파일 우클릭으로 고급 인쇄 옵션 제공

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Ubuntu](https://img.shields.io/badge/ubuntu-24.04%20LTS-orange.svg)
![Nautilus](https://img.shields.io/badge/nautilus-46.x-green.svg)
![Python](https://img.shields.io/badge/python-3.12-blue.svg)

## 🐧 지원 플랫폼

- ✅ **Ubuntu 24.04 LTS** (권장)
- ✅ **Ubuntu 22.04 LTS** (테스트됨)
- ⚠️ **다른 배포판**: GNOME + Nautilus 환경이면 작동 가능하나 테스트되지 않음
  - Fedora (GNOME)
  - Debian (GNOME)
  - 기타 GNOME 기반 배포판
- ❌ **KDE Plasma**: 지원하지 않음 (Dolphin 파일 매니저)
- ❌ **Xfce/MATE**: 지원하지 않음 (Nautilus 미사용)

## ✨ 기능

### 📐 고급 인쇄 옵션
- **크기 조절**
  - 꽉 차게 (Fit to Page)
  - 실제 크기 (100%)
  - 축소만 (Shrink to Fit)
  - 사용자 정의 (10-500%)

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
- ✅ 우클릭 메뉴 직접 통합 (Scripts 폴더 불필요)
- ✅ 여러 파일 선택 시 각각 별도 페이지로 인쇄
- ✅ 이미지 파일만 메뉴 표시
- ✅ 한글 UI

## 📦 설치

### Ubuntu 24.04 LTS (권장)

원라이너 설치:
```bash
curl -fsSL https://raw.githubusercontent.com/jachuri/nautilus-image-print/master/install.sh | bash
```

또는 수동 설치:
```bash
# 저장소 클론
git clone https://github.com/jachuri/nautilus-image-print.git
cd nautilus-image-print

# 설치 실행
./install.sh
```

### Ubuntu 22.04 LTS

동일한 방법으로 설치 가능하나, Nautilus 버전 차이로 인해 일부 기능이 다를 수 있습니다.

### 다른 GNOME 배포판

```bash
# Fedora
sudo dnf install nautilus-python
git clone https://github.com/jachuri/nautilus-image-print.git
cd nautilus-image-print
./install.sh

# Debian
sudo apt install python3-nautilus
git clone https://github.com/jachuri/nautilus-image-print.git
cd nautilus-image-print
./install.sh
```

## 🔧 요구사항

### 필수
- **Ubuntu 24.04 LTS** 또는 GNOME 46.x 환경
- **Nautilus** 46.x (GNOME Files)
- **Python** 3.12 이상
- `python3-nautilus` 패키지

### 권장
- GTK 3.0 (보통 기본 설치됨)
- CUPS 프린터 시스템

## 📖 사용 방법

1. 파일 매니저(Nautilus)에서 이미지 파일 선택
2. **우클릭 → 인쇄**
3. "이미지 설정" 탭에서 옵션 조절
4. 인쇄!

## 🗂️ 파일 구조

```
nautilus-image-print/
├── install.sh           # 설치 스크립트
├── 인쇄                 # 메인 인쇄 스크립트 (Python GTK)
├── quick_print.py       # Nautilus Python 확장
└── README.md            # 문서
```

## 🔄 업데이트

```bash
cd nautilus-image-print
git pull
./install.sh
```

## ❌ 제거

```bash
rm ~/.local/share/nautilus/scripts/.hidden/인쇄
rm ~/.local/share/nautilus-python/extensions/quick_print.py
nautilus -q
```

## 🐛 문제 해결

### Ubuntu에서 메뉴가 보이지 않아요
```bash
# Nautilus 재시작
nautilus -q

# python3-nautilus 재설치
sudo apt install --reinstall python3-nautilus
```

### 다른 배포판에서 작동하지 않아요
```bash
# Nautilus 버전 확인
nautilus --version

# Python-Nautilus 설치 확인
python3 -c "from gi.repository import Nautilus; print('OK')"
```

### 인쇄 대화상자가 열리지 않아요
```bash
# 로그 확인
cat /tmp/nautilus_print_python.log

# 스크립트 권한 확인
ls -l ~/.local/share/nautilus/scripts/.hidden/인쇄
```

## 💡 작동 원리

1. **Python-Nautilus**: Nautilus 확장 API를 사용하여 우클릭 메뉴에 "인쇄" 항목 추가
2. **GTK PrintOperation**: GTK의 네이티브 인쇄 대화상자 사용
3. **커스텀 탭**: 이미지 전용 설정을 위한 커스텀 탭 추가

## ⚠️ 제한사항

- **Ubuntu/GNOME 전용**: KDE, Xfce 등 다른 데스크톱 환경에서는 작동하지 않습니다
- **Nautilus 의존성**: Dolphin, Thunar 등 다른 파일 매니저는 지원하지 않습니다
- **Python 3.12+**: 이전 버전의 Python에서는 테스트되지 않았습니다

## 🤝 기여

이슈와 풀 리퀘스트를 환영합니다!

특히 다음 기여를 환영합니다:
- 다른 배포판 테스트 결과
- 번역 (영문, 일문 등)
- 버그 리포트
- 기능 제안

## 📄 라이선스

MIT License

## 🙏 감사

- GTK Team
- GNOME Nautilus Team
- Python-Nautilus Contributors
- Ubuntu Community

---

**제작일**: 2025-10-05  
**플랫폼**: Ubuntu 24.04 LTS / GNOME 46  
**제작자**: [@jachuri](https://github.com/jachuri)  
**레포지토리**: https://github.com/jachuri/nautilus-image-print
