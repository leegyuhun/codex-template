# 유지보수 규칙

유지보수 작업은 코드의 아름다움보다 안정성과 기존 동작 보존을 우선한다.

## 원인 분석

수정하기 전에 다음을 확인한다.

1. 실제 오류가 발생하는 실행 경로
2. 관련 Caller와 Event/Callback
3. 입력 → 처리 → 출력의 데이터 흐름
4. 관련 DB Query 또는 External API 호출
5. 다른 화면/모듈의 유사 로직
6. OS, Runtime, DB, Encoding 등의 환경 차이
7. 최근 변경과의 연관성

## 수정 정책

우선:

- 가장 작은 안전한 Diff
- 기존 코드 패턴
- 기존 Library/Component
- 하위 호환성
- 국소적 수정
- 원인 자체를 해결하는 수정

명시적으로 요청하지 않았다면 피한다.

- 광범위한 Refactoring
- Naming 일괄 변경
- Directory 구조 변경
- Framework Migration
- Dependency Upgrade
- API Signature 변경
- Schema 재설계
- UI 전면 재구성

## Legacy Code

Legacy Code를 단순히 오래되었다는 이유로 다시 작성하지 않는다.

먼저 다음을 확인한다.

- 왜 이런 구현이 존재하는가
- 어떤 환경/고객/데이터가 의존하는가
- 오래된 Compiler/Runtime 호환성 때문인가
- 외부 시스템 Contract 때문인가
- 과거 장애 대응을 위한 방어 코드인가

## 버그 수정 절차

1. 현상을 재현하거나 실패 조건을 논리적으로 특정한다.
2. 증상과 Root Cause를 구분한다.
3. 영향 범위를 찾는다.
4. 가능한 한 Root Cause를 최소 수정한다.
5. 동일 원인을 공유하는 인접 경로를 확인한다.
6. Regression Test 또는 Targeted Validation을 수행한다.
7. 수정 이유를 보고한다.

## 고위험 영역

다음 영역은 특히 신중하게 다룬다.

- DB Schema / Migration
- 금액/보험/청구/정산 계산
- 날짜/시간/Timezone
- 문자 Encoding
- Thread / Synchronization
- Network Protocol
- Binary/File Format
- External API Contract
- Legacy OS/Client Compatibility
- 권한/인증/보안
