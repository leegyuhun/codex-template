# Spring Boot 규칙

## 기본 구조

기존 Layer 구조를 우선한다.

일반적으로 다음 책임을 섞지 않는다.

- Controller: Request/Response, Validation, HTTP 처리
- Service: Application/Business Orchestration
- Repository/DAO: Persistence
- DTO: 외부/계층간 데이터 전달

## Dependency Injection

프로젝트 관례가 허용하면 Constructor Injection을 우선한다.
기존 프로젝트가 다른 방식으로 통일되어 있다면 일관성을 먼저 고려한다.

## API 변경

다음을 확인한다.

- Request 하위 호환성
- Response 하위 호환성
- Validation
- Exception Mapping
- HTTP Status
- Transaction Boundary

## Transaction

`@Transactional` 범위를 임의로 넓히지 않는다.
External API Call과 DB Transaction을 함께 묶을 때 Timeout/Lock/Rollback 영향을 확인한다.

## Data Access

프로젝트가 JdbcTemplate/JPA/MyBatis 등 특정 방식을 사용하고 있다면 이를 우선한다.
유지보수 작업에서 Persistence 기술을 임의로 교체하지 않는다.
