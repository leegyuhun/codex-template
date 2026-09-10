# DB 변경 작업 규칙

DB 관련 변경은 `.codex/database.md`를 함께 따른다.

구현 전에 다음을 분석한다.

1. 현재 Schema
2. 관련 Query
3. Index
4. 데이터 규모
5. Lock/Transaction 영향
6. Migration 순서
7. Rollback 방법
8. 구버전 Application 호환성

DDL/DML을 제안할 때는 운영 영향과 실행 순서를 설명한다.
파괴적 변경은 명시적 요구가 없는 한 수행하지 않는다.
