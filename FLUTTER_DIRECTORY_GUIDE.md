# Flutter 디렉토리 구조 가이드 (입문용)

이 문서는 Flutter를 처음 시작할 때 "어디에 코드를 작성해야 하는지", "각 폴더는 무슨 역할인지", "실무에서 자주 쓰는 구조"를 빠르게 이해하기 위한 가이드입니다.

## 1) 가장 중요한 원칙

Flutter에서 **내가 직접 작성하는 앱 코드의 중심은 `lib/`** 입니다.

- 화면(UI)
- 상태관리
- 비즈니스 로직
- 데이터 모델
- 서비스(API, 로컬 저장소)

위 내용은 거의 모두 `lib/` 아래에서 관리합니다.

## 2) 현재 프로젝트 폴더 설명

현재 프로젝트(`zestify`) 기준으로 주요 폴더 의미는 아래와 같습니다.

### `lib/`

앱 코드의 핵심 폴더입니다.

- 시작점: `lib/main.dart`
- 화면 파일(`screens`, `pages`)
- 재사용 위젯(`widgets`)
- 로직/서비스(`services`, `repositories`, `providers` 등)

### `test/`

테스트 코드 위치입니다.

- 위젯 테스트
- 단위 테스트
- 통합 테스트(별도 `integration_test/`를 쓰기도 함)

### `android/`, `ios/`

모바일 네이티브 설정 폴더입니다.

- 앱 권한
- 앱 아이콘/앱 이름
- 배포 서명 설정
- 플랫폼별 빌드 설정

앱 기능 대부분은 `lib/`에서 만들고, 이 폴더는 플랫폼 설정이 필요할 때만 주로 수정합니다.

### `web/`

Flutter Web 실행 시 필요한 정적 파일/설정입니다.

### `windows/`, `macos/`, `linux/`

데스크톱 플랫폼 타겟을 위한 설정/러너 코드입니다.

### `build/`

빌드 산출물(자동 생성)입니다.

- 직접 수정하지 않습니다.
- 필요 시 삭제 후 다시 빌드해도 됩니다.

### `.dart_tool/`

Dart/Flutter 내부 캐시 및 도구 메타 데이터(자동 생성)입니다.

- 직접 수정하지 않습니다.

### `pubspec.yaml`

프로젝트의 핵심 설정 파일입니다.

- 패키지 의존성
- 에셋(이미지/폰트)
- 프로젝트 정보

패키지 추가/에셋 등록할 때 자주 수정합니다.

### `pubspec.lock`

의존성 버전 잠금 파일입니다.

- 팀/배포 환경에서 버전 일관성 유지에 사용됩니다.

## 3) 어디에 코드를 작성해야 하나?

입문자 기준으로는 아래만 기억하면 됩니다.

1. 앱 시작/라우팅: `lib/main.dart`
2. 화면 페이지: `lib/screens/...`
3. 공통 위젯: `lib/widgets/...`
4. API/인증/스토리지: `lib/services/...`
5. 데이터 모델: `lib/models/...`

즉, **대부분 `lib/`에 작성**합니다.

## 4) 실무에서 자주 쓰는 일반적인 구조

프로젝트가 커지면 보통 다음 형태 중 하나를 사용합니다.

---

## A. 기능 중심(Feature-first) 구조 (권장)

작은 팀/중간 규모 이상에서 유지보수가 좋은 편입니다.

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
    theme.dart
  core/
    constants/
    utils/
    network/
    error/
  features/
    auth/
      presentation/
        pages/
          login_page.dart
        widgets/
      domain/
        entities/
        usecases/
      data/
        models/
        repositories/
        datasources/
    home/
      presentation/
      domain/
      data/
  shared/
    widgets/
    providers/
```

장점:

- 기능(auth, home 등) 단위로 파일이 모여 찾기 쉽습니다.
- 팀 협업 시 충돌이 줄어듭니다.
- 기능 확장 시 구조가 잘 버팁니다.

---

## B. 레이어 중심(Layer-first) 구조

초기 학습은 쉽지만, 프로젝트 커지면 기능 추적이 불편할 수 있습니다.

```text
lib/
  main.dart
  screens/
  widgets/
  models/
  services/
  repositories/
  providers/
```

장점:

- 처음에는 단순하고 이해가 쉽습니다.

단점:

- auth 관련 파일이 여러 폴더로 흩어져서 관리가 어려워질 수 있습니다.

## 5) 초반 추천 구조 (입문 + 확장 가능)

처음에는 아래처럼 시작하고, 나중에 feature-first로 점진 전환하는 방법이 좋습니다.

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
  screens/
    login_page.dart
    home_page.dart
  widgets/
    app_text_field.dart
    app_button.dart
  services/
    auth_service.dart
  models/
    user.dart
  core/
    constants.dart
```

## 6) 파일 네이밍/코드 배치 규칙 추천

- 파일명: `snake_case.dart`
  - 예: `login_page.dart`, `auth_service.dart`
- 클래스명: `PascalCase`
  - 예: `LoginPage`, `AuthService`
- 파일 하나에 너무 많은 책임을 넣지 않기
- "화면 + 로직 + 네트워크"를 한 파일에 몰아넣지 않기

## 7) 로그인 화면은 어디에 두면 되나?

일반적으로 아래 둘 중 하나를 선택합니다.

1. 단순 구조: `lib/screens/login_page.dart`
2. 기능 중심 구조: `lib/features/auth/presentation/pages/login_page.dart`

처음에는 1번으로 시작하고, 기능이 커지면 2번으로 전환하는 것을 권장합니다.

## 8) 언제 `android/ios`를 만지나?

아래 상황에서만 주로 수정합니다.

- 카메라/위치/알림 권한 설정
- 앱 아이콘/앱 이름 변경
- 딥링크/푸시 관련 플랫폼 설정
- 스토어 배포용 서명 설정

그 외 일반 UI/비즈니스 로직 작업은 대부분 `lib/`에서 해결됩니다.

## 9) 요약

- Flutter 개발의 중심은 `lib/`
- `main.dart`는 시작점, 화면/기능은 하위 폴더로 분리
- 초반은 단순 구조로 시작하고, 커지면 feature-first 구조로 전환
- `build/`, `.dart_tool/`는 자동 생성 폴더라 직접 수정하지 않음

---

필요하면 다음 단계로 `zestify` 프로젝트에 맞춰 실제 폴더를 생성하고, `login_page.dart`까지 연결한 기본 라우팅 템플릿을 바로 적용할 수 있습니다.
