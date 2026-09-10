# PostgreSQL 규칙

- PostgreSQL Version과 Extension 사용 여부를 확인한다.
- Query 변경 시 `EXPLAIN`/`EXPLAIN ANALYZE` 필요성을 검토한다.
- Index Column 순서는 실제 Predicate/Join/Order By 패턴을 기준으로 결정한다.
- 대용량 Table의 DDL은 Lock과 Rewrite 가능성을 확인한다.
- 운영 중 Index 추가는 필요 시 `CREATE INDEX CONCURRENTLY`를 검토한다.
- `CONCURRENTLY`는 일반 Transaction Block 안에서 실행할 수 없는 점을 고려한다.
- Sequence/Identity 동작을 확인한다.
- Partition Table 수정 시 Default Partition 및 Partition Constraint를 확인한다.
- Timezone, `timestamp`와 `timestamptz` 차이를 명확히 한다.
