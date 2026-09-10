# AGENTS.md

## 목적

이 저장소는 Codex를 신규 개발, 유지보수, 버그 수정, 리팩터링, 코드 리뷰, DB 변경 및 릴리스 검증에 활용한다.
이 파일은 저장소 전체에 적용되는 최상위 개발 규칙이다. 세부 규칙은 `.codex/` 아래 문서를 따른다.

## 작업 시작 전 필수 확인

Codex는 코드를 수정하기 전에 작업과 관련된 문서를 먼저 확인한다.

공통:
- `.codex/project.md`
- `.codex/architecture.md`
- `.codex/coding-rules.md`
- `.codex/workflow.md`
- `.codex/testing.md`

유지보수/버그 수정:
- `.codex/maintenance.md`
- `.codex/prompts/bug-fix.md`

신규 기능:
- `.codex/prompts/new-feature.md`

리팩터링:
- `.codex/prompts/refactoring.md`

DB 변경:
- `.codex/database.md`
- `.codex/prompts/db-change.md`

코드 리뷰:
- `.codex/prompts/code-review.md`

릴리스 점검:
- `.codex/prompts/release-check.md`

기술스택별 규칙:
- `.codex/stack/*.md`

## 최우선 원칙

1. 수정하기 전에 먼저 이해한다.
2. 요구사항이 명시적으로 변경하지 않은 기존 동작은 보존한다.
3. 유지보수는 가능한 한 작은 범위의 안전한 변경을 우선한다.
4. 새로운 패턴을 도입하기 전에 현재 저장소의 구조와 관례를 따른다.
5. 버그 수정 중 관련 없는 리팩터링이나 정리를 함께 수행하지 않는다.
6. Public API, DB Schema, 파일 포맷, 네트워크 프로토콜, 외부 연동 규격, 지원 OS/런타임을 조용히 변경하지 않는다.
7. 오래된 코드라도 이유를 확인하기 전에는 불필요한 코드라고 단정하지 않는다.
8. 고위험 영역을 수정할 때는 영향 범위와 회귀 가능성을 명시한다.
9. 가능한 테스트, 빌드, 정적 분석, 수동 검증 중 가장 강한 방법으로 변경을 검증한다.
10. 작업 완료 시 변경 내용, 이유, 영향, 위험, 검증 결과를 요약한다.

## 코드 수정 전 확인 순서

1. 요구사항과 기대 결과를 정리한다.
2. 실제 Entry Point를 찾는다.
3. 호출 관계와 의존성을 추적한다.
4. 데이터 흐름을 확인한다.
5. 유사 구현과 기존 패턴을 찾는다.
6. 버전/환경/호환성 제약을 확인한다.
7. 최소 수정 범위를 결정한다.
8. 검증 방법을 결정한 뒤 수정한다.

## 금지 원칙

명확한 작업 이유가 없는 한 다음을 하지 않는다.

- 파일/클래스/컴포넌트 이름 일괄 변경
- 폴더 구조 재편
- 의존성 또는 프레임워크 버전 업그레이드
- 기존 라이브러리의 임의 교체
- 방어 코드 제거
- Public API Signature 변경
- DB Schema의 파괴적 변경
- 운영 데이터 삭제/초기화
- 기존 호환성 범위 축소
- 관련 없는 Formatting 또는 대규모 Cleanup

## 작업 모드

### 신규 기능
`.codex/prompts/new-feature.md`를 따른다.

### 버그 수정 / 유지보수
`.codex/prompts/bug-fix.md`와 `.codex/maintenance.md`를 따른다.

### 리팩터링
`.codex/prompts/refactoring.md`를 따른다.

### DB 변경
`.codex/prompts/db-change.md`와 `.codex/database.md`를 따른다.

### 코드 리뷰
`.codex/prompts/code-review.md`를 따른다.

### 릴리스 점검
`.codex/prompts/release-check.md`를 따른다.

## 완료 보고 형식

가능한 경우 다음 내용을 보고한다.

- 요구사항 해석
- 원인 또는 구현 전략
- 수정한 파일
- 주요 변경점
- 기존 동작에 미치는 영향
- 호환성 영향
- 회귀 위험
- 수행한 테스트/검증
- 수행하지 못한 검증과 이유
- 추가로 확인할 사항
