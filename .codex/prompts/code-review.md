# 코드 리뷰 규칙

Code Review는 스타일 취향보다 실제 결함과 위험을 우선한다.

우선순위:

1. Correctness Bug
2. Data Loss / Security Risk
3. Regression Risk
4. Concurrency / Transaction 문제
5. Compatibility 문제
6. Performance 문제
7. Maintainability
8. Style

각 Finding은 가능한 경우 다음을 포함한다.

- 심각도
- 파일/위치
- 문제 설명
- 발생 조건
- 영향
- 권장 수정 방향

근거가 약한 추측은 사실처럼 단정하지 않는다.
