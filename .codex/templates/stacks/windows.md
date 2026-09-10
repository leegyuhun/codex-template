# Windows 규칙

- 프로젝트가 지원하는 최소 Windows Version을 먼저 확인한다.
- 최신 Windows API를 사용할 경우 최소 지원 OS에서 사용 가능한지 확인한다.
- Registry, Service, UAC, Path, File Permission 차이를 고려한다.
- x86/x64 차이와 WOW64 영향을 확인한다.
- System Encoding/Locale 의존성을 확인한다.
- UI/COM/OLE 관련 코드는 Main Thread 및 Apartment Model 영향을 고려한다.
