# Flutter 세팅 & 프로젝트 시작 가이드 (Windows)

작성일: 2026-02-23 | 환경: Windows 10, VS Code

---

## Step 1. PowerShell 실행 정책 허용

PowerShell을 **관리자 권한**으로 열고 아래 명령어 실행.
(VS Code 우클릭 → 관리자 권한으로 실행 후 터미널 열어도 됨)

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

`Y` 입력 후 엔터. 이걸 안 하면 npm, flutter 등 명령어가 막힘.

---

## Step 2. Flutter SDK 설치

1. https://docs.flutter.dev/get-started/install/windows 접속
2. **Download Flutter SDK** 클릭 (ZIP 파일)
3. `C:\flutter` 경로에 압축 해제
   - 주의: 경로에 **한글, 공백 절대 금지** (예: `C:\Users\홍길동\flutter` 안됨)
4. 시스템 환경변수 PATH에 `C:\flutter\bin` 추가
   - 시작 → "환경 변수" 검색 → 시스템 변수 → Path → 편집 → 새로 만들기 → `C:\flutter\bin` 입력

설치 확인:
```powershell
flutter --version
```

정상 출력 예시:
```
Flutter 3.41.2 • channel stable
Dart 3.11.0 • DevTools 2.54.1
```

---

## Step 3. Android Studio 설치

1. https://developer.android.com/studio 에서 다운로드 후 설치
2. 설치 완료 후 Android Studio 실행
3. `More Actions` → `SDK Manager` 클릭
4. 상단 `SDK Tools` 탭 클릭
5. `Android SDK Command-line Tools (latest)` 체크 → **Apply** → OK

---

## Step 4. 라이선스 동의

```powershell
flutter doctor --android-licenses
```

프롬프트가 나올 때마다 `y` 입력.
마지막에 `All SDK package licenses accepted` 나오면 완료.

---

## Step 5. 환경 최종 확인

```powershell
flutter doctor
```

Android 개발 기준 정상 상태:
```
[√] Flutter
[√] Android toolchain
[√] Chrome
[!] Visual Studio  ← Windows 데스크톱 앱 전용, Android엔 무관하므로 무시
```

---

## Step 6. VS Code 익스텐션 설치

VS Code 익스텐션 탭에서 아래 2개 설치:
- **Flutter** (Dart Code 제작)
- **Dart** (자동 설치됨)

---

## Step 7. 새 프로젝트 생성 & 열기

```powershell
cd C:\Users\Owner\Desktop\coding\park
flutter create zestify
cd zestify
code .
```

- `flutter create zestify` : 프로젝트 생성
- `code .` : VS Code로 프로젝트 열기

---

## Step 8. 앱 실행

에뮬레이터 또는 안드로이드 기기 연결 후:

```powershell
flutter run
```

실행 중 유용한 키:
- `r` : Hot Reload (코드 변경사항 즉시 반영)
- `R` : Hot Restart (앱 재시작)
- `q` : 종료

---

## 다음 학습 순서

1. `lib/main.dart` 구조 읽기
2. `StatelessWidget` vs `StatefulWidget` 차이 이해
3. `Text`, `Column`, `Row`, `Container`, `ElevatedButton` 연습
4. Hot Reload 습관 만들기
5. 간단한 화면 1개 직접 만들기
