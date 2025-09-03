# 레벨3 최종미션 인프라 구조

## 서버 관련
총 세 대의 서버가 운영 중입니다(dev 서버, prod 서버, MySQL 전용 서버). 모든 서버는 프라이빗 서브넷에 위치해 있어서 외부에서 접근할 수 없습니다.  
그 대신 서버 앞단에 리버스 프록시 역할을 담당하고 있는 로드밸런서를 설치하여 사용자는 HTTPS 프로토콜을 통해 안전하게 요청할 수 있습니다.

### 서비스에 접근하기 위한 로드 밸런서 주소
- https://reservationfinal.shop : 상용 서버로 접근
- https://dev.reservationfinal.shop : 개발 서버로 접근

## DB 관련
- 개발 서버의 DB는 개발 서버 내부에서 Docker로 띄우고 있습니다. 변경될 여지가 많고 민감한 정보가 포함되지 않을 거라고 생각해서 개발 서버의 DB는 분리할 필요를 느끼지 못했습니다.  
- 상용 서버의 DB는 별개의 EC2 서버로 분리되어 있습니다. 상용 서버의 EC2 인스턴스가 종료되더라도 DB는 영향을 받지 않으며, 저장되어 있는 데이터가 삭제되지 않습니다.

## CI/CD 관련
- CI: develop나 release 브랜치로 푸시되면 자동으로 github 가상머신에서 gradle 테스트를 수행합니다.
- CD: develop 브랜치에 푸시되면 dev 서버로, release 브랜치로 푸시되면 prod 서버로 자동 배포를 수행합니다.

## API 명세
- /reservations (GET, POST)
- /reservations/period (GET)
- /reservations/member/{name} (GET)
- /reservations/{id} (GET, PATCH, DELETE)
- /reservations/times (GET, POST)
- /members/signUp (POST)
- /members/login (POST)
- /holidays (POST)
- /holidays/national (POST)