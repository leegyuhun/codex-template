# Delphi 2007 규칙

## 호환성

이 프로젝트는 Delphi 2007 Compiler/RTL 호환성을 유지해야 한다.
최신 Delphi에서만 지원하는 문법이나 RTL API를 사용하지 않는다.

특히 다음 기능 사용 전 Delphi 2007 지원 여부를 확인한다.

- Generics
- Anonymous Method
- 최신 `TFile`/`TPath` API
- 최신 `TEncoding` 의존 코드
- 최신 Language Syntax
- Unicode String 전제 코드

## 문자열 / Encoding

Delphi 2007의 `string`은 기본적으로 ANSI 기반이라는 점을 고려한다.
외부 API, JSON, DB, File I/O에서 UTF-8/ANSI 변환을 명시적으로 확인한다.
Encoding 변경은 Regression Risk가 높은 작업으로 취급한다.

## 메모리 관리

다음 객체의 Ownership을 반드시 확인한다.

- `TObject`
- `TStringList`
- `TStream`
- Dataset/Query 객체
- COM/OLE 객체

필요한 경우 `try/finally`로 해제를 보장한다.

## UI

버그 수정 중 Form 전체를 재설계하지 않는다.
명시적 요구가 없는 한 다음을 보존한다.

- Component Name
- Event Handler
- Tab Order
- 기존 UI Flow
- DFM 호환성

## DB / COM 연동

기존 UniDAC, ADO, COM/OLE, Excel Automation 등 프로젝트에서 사용하는 방식을 우선한다.
새로운 Library로 임의 교체하지 않는다.
