# Microsoft SQL Server 규칙

- 실제 SQL Server Version과 Compatibility Level을 확인한다.
- Index/Execution Plan/Parameter Sniffing 영향을 필요한 경우 확인한다.
- Transaction과 Lock Escalation 가능성을 고려한다.
- `datetime`, `datetime2`, `date` 등의 타입 차이를 명확히 한다.
- 운영 대용량 Table의 DDL은 Lock 시간을 고려한다.
