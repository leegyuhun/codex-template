# REST API 규칙

- 기존 URL, HTTP Method, Request/Response Contract를 가능한 한 보존한다.
- Breaking Change는 명시적으로 보고한다.
- Validation과 Error Response 형식을 기존 API와 일관되게 유지한다.
- 인증/인가가 필요한 Endpoint에서 기존 Security 정책을 우회하지 않는다.
- Pagination, Idempotency, Timeout, Retry 특성을 필요한 경우 확인한다.
