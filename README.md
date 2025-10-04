# Nautilus 이미지 인쇄 확장 기능

이미지 파일을 우클릭해서 바로 인쇄 대화상자를 여는 Nautilus 확장 기능입니다.

## 기능

- ✅ 이미지 파일 우클릭 → **인쇄** 메뉴
- ✅ 풍부한 인쇄 옵션
  - 크기 조절 (꽉차게/실제크기/축소만/사용자정의 %)
  - 정렬 (가운데/좌상단/우상단/좌하단/우하단)
  - 여백 설정 (없음/기본/사용자정의 mm)
  - 회전 (자동/0°/90°/180°/270°)
  - DPI 설정 (150/300/600)
  - 가로세로 비율 유지
- ✅ 여러 파일 선택 시 각각 별도 페이지로 인쇄

## 설치 방법

```bash
cd ~/backup/nautilus_print_extension
./install.sh
```

설치 후 Nautilus를 재시작하세요:
```bash
nautilus -q
```

## 사용 방법

1. 파일 매니저에서 이미지 파일 선택
2. 우클릭 → **인쇄**
3. 인쇄 설정 조절
4. 인쇄!

## 파일 구조

```
nautilus_print_extension/
├── install.sh           # 설치 스크립트
├── 인쇄                 # 메인 인쇄 스크립트 (Python GTK)
├── quick_print.py       # Nautilus Python 확장
└── README.md            # 이 파일
```

## 필요 패키지

- `python3-nautilus` - Nautilus Python 확장 지원
- `python3-gi` - GTK 바인딩 (보통 기본 설치됨)

## 재설치 시

1. 이 폴더를 USB나 클라우드에 백업
2. 새 시스템에서 폴더 복사
3. `./install.sh` 실행

## 제거 방법

```bash
rm ~/.local/share/nautilus/scripts/.hidden/인쇄
rm ~/.local/share/nautilus-python/extensions/quick_print.py
nautilus -q
```

---

**제작일**: 2025-10-05  
**Ubuntu 버전**: 24.04 LTS  
**Nautilus 버전**: 46.x
