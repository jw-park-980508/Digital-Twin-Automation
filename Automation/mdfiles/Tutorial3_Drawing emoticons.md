

# Tutorial3 : Drawing Emoticons

본 튜토리얼은 Manupulator를 사용하여 앞서 얻은 좌표대로 drawing을 하는 Tutorial이다. 

### 1) IndyDCP

Reference Link: [Neuromeka](http://docs.neuromeka.com/2.3.0/en/Python/section1/)

IndyDCP는ROS를 사용하지 않고 Neruomeka에서 제공하는 Indy-10을 사용하기 위해 제공하는 Library이다. IndyDCP는 Python에서 사용 가능하다. 설치방법은 다음과 같다.  [***Download Python IndyDCP Client\***](https://s3.ap-northeast-2.amazonaws.com/download.neuromeka.com/Examples/indydcp_example.zip) 해당 링크를 눌러 다운 받고 알집을 실행할 .py파일과 같은 Directory에 위치 시킨다.

```python
from indy_utils import indydcp_client as client

robot_ip = "192.168.0.6"  # Robot (Indy10) IP
robot_name = "NRMK-Indy10"  # Robot name (Indy10)indy

# Create class object
indy = client.IndyDCPClient(robot_ip, robot_name)

indy.connect()
```

위 코드를 입력시 Indy-10 Manipulator와 연결이 된다.



```python
indy.set_collision_level(5)
indy.set_joint_vel_level(7)
indy.set_task_vel_level(7)
indy.set_joint_blend_radius(20)
indy.set_task_blend_radius(0.2)
```

위 의 코드로 Manipulator의 기능을 Setting한다. 함수에 대한 설명은 Reference Link에 추가적으로 제시하고 있다.



```python
indy.go_home()

key = ['ready', 'emergency', 'collision', 'error', 'busy', 'movedone', 'home', 'zero', 'resetting', 'teaching', 'direct_teaching']

while True:
	status = indy.get_robot_status()
    sleep(0.2)
	if status[key[5]]==1 :
        break
```

ROS를 동작하기 위해서는 위와 같은 충돌을 방지하는 코드가 필요하다

**Status**에는 위의 Text들이 Dictionary형태로 저장되어있다.  따라서 key[5]는 movedone을 의미한다. 

**!주의!** 움직임 끝나지 않은 상태에서 다른 명령을 주게 되면 해당 Library에서 Task가 꼬이게 되는 일이 발생한다. 