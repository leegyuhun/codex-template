# Batch 규칙

- 재실행 가능성(Idempotency)을 확인한다.
- 중간 실패 후 Resume/Retry 동작을 확인한다.
- 대량 데이터 처리 시 Memory와 Transaction Size를 고려한다.
- 중복 처리 방지 방법을 확인한다.
- 실행 이력과 실패 원인을 추적할 수 있는 Logging을 유지한다.
- 외부 API Batch 호출은 Rate Limit/Timeout/Retry를 고려한다.
