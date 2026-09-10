# 릴리스 점검 규칙

릴리스 전 다음을 확인한다.

- Build/Compile 성공 여부
- 자동 테스트 결과
- 주요 Regression Check
- Config 변경
- DB Migration 존재 여부
- API Contract 변경
- 외부 Dependency 변경
- 지원 OS/Runtime 호환성
- Logging/Monitoring 영향
- Rollback 방법
- 배포 순서

확인하지 못한 항목은 확인 완료로 표시하지 않는다.
