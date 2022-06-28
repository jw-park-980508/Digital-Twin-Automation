

# Tutorial3 : Drawing Emoticons

본 튜토리얼은 Manupulator를 사용하여 앞서 얻은 좌표대로 drawing을 하는 Tutorial이다. 본 튜토리얼을 실행해보기 위해서는 **앞의 튜토리얼들을 모두 실행해봐야 하며, 그리기 위한 CSV파일이 필요**하다.



또한, **파일들의 directory가 중요**하다. github의 source폴더와 동일한 위치에 emoticon과 감정에 따른 CSV파일이 존재해야 에러가 발생하지 않는다.



### Overview

Drawing의 순서는 다음과 같다.

Step 1. 로봇 연결

Step 2. 초기 그림을 그리는 좌표로 이동한다.

Step 3. CSV파일에 저장된 좌표대로 로봇이 움직이면서 그림을 그린다.

step 4. Home position으로 돌아간다.



### Step1 : 로봇 연결 

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

**ROS를 동작하기 위해서 주의해야할 점은 다음과 같다.**

```python
indy.go_home()

key = ['ready', 'emergency', 'collision', 'error', 'busy', 'movedone', 'home', 'zero', 'resetting', 'teaching', 'direct_teaching']

while True:
	status = indy.get_robot_status()
    sleep(0.2)
	if status[key[5]]==1 :
        break
```

**동작이 끝난 이후**에 **새로운 동작**의 명령이 주어져야 한다.

**Status**에는 위의 Text들이 Dictionary형태로 저장되어있다.  따라서 key[5]는 movedone을 의미한다. 

**움직임 끝나지 않은 상태에서 다른 명령을 주게 되면 ROS가 동작하지 못한다.** 



### Step2 : draw_start() - 초기 좌표 이동

홈에서 그림을 그리기 위한 초기 좌표로 이동한다.

```python
def draw_start():
    # board marker start position
    indy.go_home()

    while True:
        status = indy.get_robot_status()
        sleep(0.2)
        if status[key[5]]==1 :
            break

    t_pos_rel = [0.20, -0.30, -0.31, 0, 48, 0] # x,y,z그리고 각도?
    indy.task_move_by(t_pos_rel)

    while True:
        status = indy.get_robot_status()
        sleep(0.2)
        if status[key[5]]==1 :
            break
    print("done going start point")
    return None
```

**Example code**

```python
draw_start()
```
Example code를 입력한다면 로봇이 그림을 그리기 위한 초기 좌표로 이동한다. 이 때의 초기좌표는 home position으로부터 상대좌표로 계산되었다.

**만일, 화이트보드의 위치와 다르다면 2가지 해결방안이 존재한다.**

1) draw_start()에 정의된 상대좌표의 수정

2)화이트보드의 위치 수정



### Step3 : draw_csv() - CSV에 저장된 좌표대로 이동

Start position에서 Z축으로 이동해 화이트보드에 펜이 닿도록하고, CSV의 좌표대로 로봇이 움직이게 한다.

```python
def draw_csv(name,ratio,resolution,directory):
    # resolution : should be integer (ex. 2 = 0.5 resolution)
    # should control Z coordinate
    data = pd.read_csv('emotion/'+directory+'/'+name+'.csv')
    data = ratio*data
    l = len(data)
    data = data[['x','y']][0:l:resolution]

    t_pos_rel = [data['x'][0*resolution], data['y'][0*resolution], 0, 0, 0, 0] # x,y,z그리고 각도?
    indy.task_move_by(t_pos_rel)

    while True:
        status = indy.get_robot_status()
        sleep(0.2)
        if status[key[5]]==1 :
            break
        
    # offset = 0.011
    offset = 0.0181  #no case
    t_pos_rel = [0, 0, -offset, 0, 0, 0] # x,y,z그리고 각도?
    indy.task_move_by(t_pos_rel)

    while True:
        status = indy.get_robot_status()
        sleep(0.2)
        if status[key[5]]==1 :
            break
    
    for i in range(len(data)):
        if i !=0:
            t_pos_rel = [data['x'][i*resolution], data['y'][i*resolution], 0, 0, 0, 0] # x,y,z그리고 각도?
            indy.task_move_by(t_pos_rel)

            while True:
                status = indy.get_robot_status()
                sleep(0.02)
                if status[key[5]]==1 :
                    break
    
    t_pos_rel = [0, 0, offset, 0, 0, 0]
    return None
```

**Parameters**

- **name**:  file name to draw
- **ratio**:  Variables that control picture size
- **resolution**: percentage of points to be drawn (shoud be integer, e.g 2=0.5 resolution)
- **directory**: The name of the folder called emotion in the same location as the code

**Example code**

```python
emotion = 'surprise'
size = 0.005
draw_csv('circle_rel',size,1,emotion)
```
**해당 코드는 주의해서 동작해야 한다.**

end-effector에 펜이 부착되기 때문에 높이 계산이 중요하다. Draw_start()로 시작 지점에서 적당한 값을 이동(**ROS의 단위는 [m]**)해야 한다. **이 때, 자로 직접 높이를 재서 입력하는 것을 추천한다.**

이 때, **이동하는 거리가 작다면 펜이 화이트보드에 닿지 못하며**, **이동거리가 크다면 펜이 뭉개진다**.



### Step4 : go_home() - home position으로 이동

indy.go_home()함수에 ROS 명령 충돌을 방지하기 위한 코드가 추가된 함수이다. (draw_start()함수에 home으로 이동하는 명령이 있지만, 상대좌표인만큼 home으로 이동하는 process까지를 한 동작으로 생각하였다.)

```python
def go_home():
    indy.go_home()

    while True:
        status = indy.get_robot_status()
        sleep(0.2)
        if status[key[5]]==1 :
            break
    print("done go home")
    return None
```

**Example code**

```python
go_home()
```
예제코드를 실행하면 home position으로 이동한다. 해당 내용은 indy_utils에도 정의되어있는 내용이다.



### 종합

위의 step들을 종합하면 다음과 같다.

```python
draw_start()
draw_csv('circle_rel',size,1,emotion)
print('draw circle_rel done')

draw_start()
draw_csv('angry_1_rel',size,1,emotion)
print('draw angry1 done')

draw_start()
draw_csv('angry_2_rel',size,1,emotion)
print('draw angry2 done')

draw_start()
draw_csv('angry_3_rel',size,1,emotion)
print('draw angry3 done')

go_home()
```
start position으로 이동한 이후, CSV파일의 좌표대로 그림을 그리고 Process가 끝난다는 문구를 출력해준다.



### Tutorial code

[Tutorial source Link](https://github.com/serengil/deepface)

```python
size = 0.005
emotion = 'happy'
```

133 ~ 134번 라인에 존재하는 emotion 변수에 확인하고 싶은 emotion을 입력해 로봇의 동작을 확인할 수 있다.