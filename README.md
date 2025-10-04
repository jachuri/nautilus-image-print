# 🖨️ Nautilus Image Print Extension

이미지 파일을 우클릭해서 바로 고급 인쇄 대화상자를 여는 Nautilus 확장 기능입니다.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Ubuntu](https://img.shields.io/badge/ubuntu-24.04-orange.svg)
![Nautilus](https://img.shields.io/badge/nautilus-46.x-green.svg)

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

## 📦 빠른 설치

### 원라이너 설치
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

## 🔧 요구사항

- Ubuntu 24.04 LTS (또는 최신 GNOME 환경)
- Nautilus 46.x
- Python 3.x
- `python3-nautilus` 패키지 (자동 설치됨)

## 📖 사용 방법

1. 파일 매니저에서 이미지 파일 선택
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

### 메뉴가 보이지 않아요
```bash
# Nautilus 재시작
nautilus -q

# python3-nautilus 재설치
sudo apt install --reinstall python3-nautilus
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

## 🤝 기여

이슈와 풀 리퀘스트를 환영합니다!

## 📄 라이선스

MIT License

## 🙏 감사

- GTK Team
- GNOME Nautilus Team
- Python-Nautilus Contributors

---

**제작일**: 2025-10-05  
**제작자**: [@jachuri](https://github.com/jachuri)  
**레포지토리**: https://github.com/jachuri/nautilus-image-print
