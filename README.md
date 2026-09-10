# Codex Project Template v2

신규 개발과 기존 프로젝트 유지보수에 공통으로 사용할 수 있는 Codex 프로젝트 템플릿이다.

문서와 규칙은 한글로 작성하고, 파일명·폴더명·커맨드·코드 식별자·기술명은 영어를 유지한다.

## 1. 설치

이 디렉터리의 내용을 대상 프로젝트 Root에 복사한다.

```text
project-root/
├─ AGENTS.md
├─ .codex/
├─ docs/
└─ scripts/
```

## 2. 프로젝트 설정

Windows PowerShell:

```powershell
.\scripts\codex-template.ps1 configure
```

CMD에서 실행하려면:

```cmd
scripts\codex-template.cmd configure
```

실행하면 프로젝트명, 프로젝트 유형, 기술스택, 호환성 제약을 입력받는다.

### 비대화형 설정

```powershell
.\scripts\codex-template.ps1 configure `
  -ProjectName "MedicalClient" `
  -ProjectType "maintenance" `
  -Stacks "delphi2007,windows,desktop-app,postgresql" `
  -Compatibility "Delphi 2007,Windows 7 이상,PostgreSQL 15"
```

### Preset 사용

```powershell
.\scripts\codex-template.ps1 configure `
  -ProjectName "LegacyEMR" `
  -ProjectType "mixed" `
  -Preset "hybrid-delphi-spring"
```

## 3. 지원 커맨드

```powershell
# 프로젝트/기술스택 설정
.\scripts\codex-template.ps1 configure

# 등록된 기술스택 확인
.\scripts\codex-template.ps1 list-stacks

# 등록된 Preset 확인
.\scripts\codex-template.ps1 list-presets

# 현재 프로젝트 설정 확인
.\scripts\codex-template.ps1 show-config

# 생성된 기술스택 규칙 제거
.\scripts\codex-template.ps1 reset-stack
```

## 4. configure 실행 결과

`configure`는 공통 규칙을 변경하지 않고 프로젝트별 파일만 재생성한다.

생성/갱신 대상:

- `.codex/project.md`
- `.codex/config/project.json`
- `.codex/architecture.md`의 자동 생성 영역
- `.codex/stack/*.md`

다음 공통 규칙은 그대로 유지한다.

- `.codex/coding-rules.md`
- `.codex/workflow.md`
- `.codex/maintenance.md`
- `.codex/testing.md`
- `.codex/database.md`
- `.codex/prompts/*.md`
- `.codex/checklists/*.md`

## 5. 기본 기술스택

- `delphi2007`
- `delphi-modern`
- `java`
- `springboot`
- `postgresql`
- `mysql`
- `mssql`
- `windows`
- `linux`
- `rest-api`
- `desktop-app`
- `batch`

## 6. Preset

### delphi-legacy

```text
delphi2007
windows
desktop-app
```

### spring-api

```text
java
springboot
rest-api
```

### spring-postgres-api

```text
java
springboot
postgresql
rest-api
linux
```

### spring-postgres-batch

```text
java
springboot
postgresql
batch
linux
```

### hybrid-delphi-spring

```text
delphi2007
windows
desktop-app
java
springboot
postgresql
rest-api
```

## 7. 기술스택 추가 방법

예를 들어 React 규칙을 추가하려면:

1. `.codex/templates/stacks/react.md` 생성
2. `.codex/config/stacks.json` 등록

```json
"react": {
  "template": "react.md",
  "category": "framework",
  "displayName": "React"
}
```

이후 다음처럼 사용할 수 있다.

```powershell
.\scripts\codex-template.ps1 configure -Stacks "springboot,postgresql,react"
```

## 8. Codex에게 작업시키는 기본 패턴

### 유지보수

```text
AGENTS.md와 관련 .codex 규칙을 먼저 확인해.

이번 작업은 유지보수 모드로 처리해.
바로 수정하지 말고 원인, 실행 경로, 영향 범위를 먼저 분석해.
관련 없는 리팩터링은 하지 말고 최소 수정으로 해결해.
검증 후 변경 내용과 회귀 위험을 보고해.
```

### 신규 기능

```text
AGENTS.md와 관련 .codex 규칙을 먼저 확인해.

이번 작업은 신규 기능 개발이야.
구현 전에 요구사항 해석, 영향 모듈, 구현 방법, DB/API 영향, 위험 요소를 정리해.
기존 아키텍처와 패턴을 우선 사용하고 구현 후 테스트 결과를 보고해.
```

## 9. 권장 운영 방식

`AGENTS.md`는 프로젝트 헌법과 문서 네비게이션 역할만 맡긴다.
세부 기술 규칙은 `.codex/stack/`, 작업 유형별 규칙은 `.codex/prompts/`, 장기 프로젝트 지식은 `.codex/context/`에 분리한다.

프로젝트 특수 규칙은 `AGENTS.md`에 계속 누적하지 말고 적절한 `.codex/` 문서에 기록한다.
