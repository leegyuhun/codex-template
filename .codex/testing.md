# 테스트 및 검증 규칙

## 기본 원칙

모든 변경은 해당 프로젝트에서 가능한 가장 강한 수준의 검증을 수행한다.

가능한 방법:

- Unit Test
- Integration Test
- Build / Compile
- Static Analysis
- Lint
- Targeted Manual Test
- SQL 실행계획 / Query 검증
- API Request/Response 검증
- UI 동작 검증
- 인접 기능 Regression Check

## 버그 수정

가능하면 다음 순서를 따른다.

1. 기존 실패 조건을 재현하거나 명확히 특정한다.
2. Regression Test 작성 가능성을 확인한다.
3. 수정한다.
4. 원래 실패 조건이 해결되었는지 확인한다.
5. 주변 정상 동작이 유지되는지 확인한다.

## 테스트가 부족한 Legacy 프로젝트

자동 테스트가 없다는 이유로 검증을 생략하지 않는다.

대신 가능한 조합을 사용한다.

- 전체 Compile
- 관련 Form/Module 수동 실행
- Test DB에서 SQL 검증
- Log 확인
- Before/After 결과 비교
- 문제 발생 조건의 재현 테스트

## 보고

작업 완료 시 다음을 명확히 구분한다.

- 실행한 검증
- 성공한 검증
- 실패한 검증
- 실행하지 못한 검증
- 실행하지 못한 이유
- 남아 있는 위험
