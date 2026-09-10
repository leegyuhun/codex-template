# 프로젝트 프로필

> `scripts/codex-template.ps1 configure` 명령으로 생성 또는 갱신된다.

## 프로젝트

- 이름: TODO
- 유형: TODO

## 기술스택

- 아직 설정되지 않음

## 호환성 제약

- 현재 지원 중인 실행 환경을 유지한다.
- 문서화되지 않은 최신 Language/Runtime 기능을 임의로 사용하지 않는다.
- External API, DB Schema, File Format, UI Behavior 변경은 호환성 민감 변경으로 취급한다.

## 프로젝트 우선순위

1. 안정성
2. 정확성
3. 유지보수성
4. 성능
5. 필요성이 입증된 경우에만 현대화

## 기술스택 규칙

생성된 기술스택별 규칙은 `.codex/stack/`에 있다.
해당 Stack의 코드를 수정하기 전에 관련 Rule File을 먼저 읽는다.
