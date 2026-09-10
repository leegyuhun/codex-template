# 코딩 규칙

## 기본 원칙

- 기존 프로젝트의 Naming, Formatting, File Organization을 우선한다.
- 영리한 코드보다 읽기 쉬운 코드를 선택한다.
- 함수와 메서드는 가능한 한 하나의 책임에 집중한다.
- 기존에 재사용 가능한 구현이 있다면 같은 Business Rule을 중복 구현하지 않는다.
- 명시적인 요구사항이 없는 한 기존 Public Behavior를 변경하지 않는다.
- 주석은 코드 문법 설명보다 비즈니스 제약, 호환성 이유, 비정상적으로 보이는 구현 이유를 설명하는 데 사용한다.

## 유지보수 코드

- 최소 Diff를 우선한다.
- 관련 없는 파일의 Cleanup을 하지 않는다.
- 필요한 경우가 아니면 Method/Class/API Signature를 변경하지 않는다.
- 기존 Logging, Validation, Error Handling을 이유 없이 제거하지 않는다.
- 오래된 코드라는 이유만으로 현대식 구현으로 교체하지 않는다.

## 신규 코드

- 기존 Abstraction과 Utility를 먼저 검토한다.
- 새로운 Layer, Pattern, Library는 실제 반복 복잡도를 줄이거나 명확한 Domain Boundary가 있을 때만 추가한다.
- 사소한 기능을 위해 새로운 Dependency를 추가하지 않는다.
- 프로젝트에서 이미 사용하는 방식과 다른 스타일을 도입할 경우 이유를 설명한다.

## 예외 처리

- Exception을 조용히 무시하지 않는다.
- 문제 분석에 필요한 Context를 남긴다.
- Log/Error Message에 Password, Token, Secret, 개인정보 등 민감정보를 노출하지 않는다.
- 복구 가능한 오류와 치명적인 오류를 구분한다.
- 기존 프로젝트의 Exception 처리 정책이 있다면 우선 따른다.

## 보안

- Credential, Token, Private Key, 운영 비밀번호를 코드에 하드코딩하지 않는다.
- 외부 입력을 신뢰하지 않는다.
- SQL은 Parameterized Query를 사용한다.
- 외부 Command 실행, 파일 경로 조작, 다운로드 파일 처리 시 Injection/Traversal 위험을 확인한다.

## 성능

- 성능 최적화는 측정 또는 명확한 병목 근거가 있을 때 수행한다.
- 유지보수 작업 중 추측에 의한 대규모 최적화를 하지 않는다.
- 반복 DB 호출, 불필요한 Network Call, 대용량 메모리 복사, UI Thread Block 가능성을 확인한다.
