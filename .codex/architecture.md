# Architecture 가이드

## 기본 원칙

현재 저장소에 이미 존재하는 Architecture를 우선한다.
현재 구조로 요구사항을 깨끗하게 해결할 수 있다면 새로운 Architecture Pattern을 도입하지 않는다.

## 구조 변경 전 확인

Architecture 수준의 변경이 필요한 경우 다음을 정리한다.

- 현재 구조
- 현재 구조의 실제 문제
- 제안 구조
- 변경 이유
- Migration 영향
- 호환성 영향
- Rollback 가능성

## 책임 경계

프로젝트가 다음과 같은 Boundary를 이미 가지고 있다면 이를 유지한다.

- UI / Presentation
- Application / Service
- Domain / Business Logic
- Persistence / Database Access
- External Integration
- Infrastructure

## 의존 방향

- 상위 Orchestration이 하위 구현 세부사항에 의존하도록 한다.
- 불필요한 Circular Dependency를 만들지 않는다.
- UI에 DB 세부사항 또는 Business Rule을 새로 밀어 넣지 않는다.
- 기존 Layer가 명확하다면 우회하지 않는다.

## 기술스택 규칙

현재 프로젝트에 활성화된 기술스택 규칙은 `.codex/stack/`에 생성된다.
해당 기술을 수정하기 전에 관련 Stack Rule을 확인한다.

<!-- GENERATED-STACKS -->
## 활성 기술스택 규칙

- 아직 설정되지 않음. `scripts/codex-template.ps1 configure`를 실행한다.
