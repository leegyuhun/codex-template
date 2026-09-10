# Database 규칙

DB 변경은 고위험 작업으로 취급한다.

## 변경 전 확인

SQL 또는 Schema를 변경하기 전에 다음을 확인한다.

1. 현재 Table/View/Constraint 정의
2. 기존 Index
3. 관련 Application Query
4. 예상 영향 Row 수
5. Transaction 범위
6. Lock 및 운영 영향
7. Rollback 방법
8. 구버전 Application과의 호환성
9. Migration 순서

## Query 규칙

- Parameterized Query를 사용한다.
- 운영 경로의 `SELECT *`는 기존 관례 또는 명확한 이유가 없는 한 피한다.
- NULL 처리 방식을 명시적으로 확인한다.
- Transaction Boundary를 확인한다.
- 대용량 Result Set은 Pagination/Streaming 필요성을 확인한다.
- 반복 실행되는 Query나 대형 Table은 Index 사용 가능성을 확인한다.
- 새 Index를 추가할 경우 읽기 이득뿐 아니라 Insert/Update 비용도 고려한다.

## Schema 규칙

분석 없이 다음 작업을 수행하지 않는다.

- Column 삭제
- Column Rename
- Data Type 변경
- Index 삭제
- 대용량 Table Rewrite
- Constraint 삭제
- Default 변경
- 데이터 일괄 삭제/초기화

## Migration

가능하면 Expand → Migrate → Contract 형태의 단계적 변경을 고려한다.
구버전 Application이 동시에 운영될 가능성이 있으면 즉시 파괴적인 Schema 변경을 피한다.

## PostgreSQL

PostgreSQL 사용 시 대용량 운영 Table의 Index 생성은 상황에 따라 `CREATE INDEX CONCURRENTLY`를 검토한다.
단, Transaction 제약과 실패 후 상태를 반드시 확인한다.
