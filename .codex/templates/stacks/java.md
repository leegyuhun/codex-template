# Java 규칙

- 프로젝트의 실제 JDK Version을 먼저 확인한다.
- 설정된 JDK보다 최신 Language/API 기능을 사용하지 않는다.
- Existing Package Structure와 Naming Convention을 따른다.
- 예외를 불필요하게 광범위하게 Catch하지 않는다.
- Resource는 try-with-resources 등 프로젝트 Version에 맞는 안전한 방식으로 정리한다.
- `equals/hashCode`, Null 처리, Collection 변경 가능성, Thread Safety를 필요한 경우 확인한다.
