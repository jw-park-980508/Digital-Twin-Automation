# Demonstration & FurtherWork

.

## 1. Demonstration

### 1) [Demo Video](https://youtu.be/i0M4RSne7zU)

### 2) [Final Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/source/Drawing.py)



## 2. Furtherwork

본 프로젝트에서 추가로 진행가능한 내용들은 다음과 같다.

1. **감정의 확률에 따른 이모티콘의 크기 조정해서 그리기**

   함수의 documentation을 보면 drawing하는 이모티콘의 size또한 input parameter로 정의된 것을 알 수 있다. 이를 활용하여 감정의 확률에 따라 이모티콘의 크기를 조정하는 것 또한 가능하다고 생각된다.

   하지만 여기에는 어려운점이 존재한다. indy_utils라이브러리에는 점들을 지정해줘서 로봇을 동작시킨다. 하지만 이 때 관절의 제한사항 때문에 이동하지 못하는 좌표가 존재한다. 이는 파이썬 코드상에서 error가 발생하는 것이 아니라 로봇과 pc간의 연결에 문제가 생긴다. 그렇기 때문에 파이썬 코드 상에서 except구문을 사용할 수 없었다. 이를 해결하기 위해서는 로봇의 move_to명령을 하기 이전에 충돌이 예상된다면, 해당 좌표로의 이동을 방지하는 코드가 필요할 것이다.



2. **캐리커쳐 그리기**

   이모티콘을 그리게 된 데에는 이유가 있다. 먼저 로봇에 곡선 형태의 움직임을 명령하는 법을 몰랐기 때문이다. 프로젝트 가장 첫 계획은 전이학습을 통한 캐리커쳐 이미지를 생성하고, 해당 이미지의 특징 경로들을 통하여 캐리커쳐를 그리는 것이었다.

   해당 과정이 성공하기 위해서 봐야할 라이브러리들은 다음과 같다.

   2.1 Pypotrace [pypotrace · PyPI](https://pypi.org/project/pypotrace/)

   	python 3.X.X버전에서 돌아가도록 한 라이브러리 [potrace/README.md at main · tatarize/potrace (github.com)](https://github.com/tatarize/potrace/blob/main/README.md)

   2.2 bezier curve움직임 명령 [ros-industrial-consortium/bezier: ROS-Industrial Special Project: 6D tool path planner (github.com)](https://github.com/ros-industrial-consortium/bezier)

   	Pypotrace를 통하여 이미지의 bezier curve를 얻어낼 수 있다. 
   	
   	그리고 해당 곡선의 모양대로 움직이도록 하는 	라이브러리 또한 존재한다. 
   	
   	두 라이브러리를 활용한다면 캐리커쳐 그리는 것도 가능할 것이다.