# Classification of 7 facial expressions &                      Drawing face emoticons with Manipulator

## 1. Introduction

이 Respository는 2202년도 1학기에 Digital Twin & Automation 수업의 Automation Part의 내용이다.

우리는 카메라를 사용하여 사람의 표정을 angry, disgust, fear, happy, sad, surprise, neutral 총 7개의 표정으로 분석하고 Manipulator를 사용하여 표정에 대한 이모티콘을 그려주는 프로젝트를 진행했다.

### 1) Flow Chart

아래 그림과 같은 순서로 프로젝트를 진행했다. 

![image](https://user-images.githubusercontent.com/84221531/173183973-03166869-b47f-462b-9c62-51cc6ae1c226.png)



### 2) HardWare

#### - **INDY-10 (Neuromeka)**

Indy - 10 은 Manipulator의 일종으로 간의 팔과 유사한 동작을 제공하는 기계적인 장치이다. 주요 기능은 팔 끝에서 공구가 원하는 작업을 할 수 있도록 특별한 로봇의 동작을 제공하는 것이다.



<p align="center">
<img src="https://user-images.githubusercontent.com/84221531/173846702-a0c6fdae-8d2a-4835-be63-b905e49f81d3.png" width="400" height="600"/> 
</p>

#### - **End-Effector**

![image](https://user-images.githubusercontent.com/107538917/176117430-a811b802-eda9-4ee8-b868-ccaf4cb71e8f.png)

위 그림은 로봇 팔이 좌표를 이동하는 그림이다. 그림에서 확인할 수 있듯이 로봇팔이 포물선을 그리면서 이동한다. 
이 경우 이모티콘이 점으로 그려진다.(점묘화) 이를 방지하고자 End Effector를 만들었다. 
End Effector는 펜이 바닥과 떨어지는 것을 막아준다. 

총 3개의 파트로 구성되어 있다.


아래 그림들(PART1,2,3)은 End - Effector를 구성하는 부품들이다.



<img src="https://user-images.githubusercontent.com/107538917/173776826-fcde3fc6-2334-4f2b-a148-d40a5a303914.PNG" width="200" height="200"/> 



​				**PART1**

<img src="https://user-images.githubusercontent.com/107538917/173777014-e73b6871-d9d9-4506-8b74-14a2b4577dab.PNG" width="200" height="200"/>

**PART2**		

<img src="https://user-images.githubusercontent.com/107538917/173776959-6cf4fa07-5a8f-45fd-8593-8ef195882312.PNG" width="200" height="200"/>

&nbsp; **PART3**







<p align="center">
<img src="https://user-images.githubusercontent.com/107538917/173785554-8bd86e44-f22d-4535-a011-2defd98e626b.png">
</p>																		

​	&nbsp;																						<p align="center">**Assemble**</p>

위 그림(Assemble)은 3개 파트와 스프링으로 연결한 모습이다.
파트1과 파트2는 스프링으로 서로 연결되어 있다. 그리고 글루건을 이용하여 펜이 파트2에 완전히 고정되어 있다. 
마지막으로 파트1과 파트2를 보호하기 위해서 파트3을 씌워주면 하드웨어 조립은 끝이다.

로봇 팔이 잡는 부분은 part1과 3이다. 이 파트들과 part2은 스프링으로 연결되어 있어 완충 효과를 볼 수 있다. 


각 부품들은 Solidworks Tool을 이용하여 디자인하였고, 3D print로 출력하였다. 
쓰고 닦을 수 있도록 수정 사인펜과 볼펜에 들어있는 스프링을 사용하였다. 
자세한 치수는 프로그램으로 확인해 보길 바란다. 

### 3) **SoftWare**


위 프로그램을 실행하기 위해 VScode 기반 Python 3.x 을 사용했고, 표정 분석을 위해 **MediaPipe** library 및 **DeepFace** library를 사용했다. 두 library의 설치 방법 및 사용방법은 아래의 Coordinate, Face Detection Part에서 설명하겠다.

또한 INDY-10 (Manipulaor)를 동작시키기 위해 **IndyDCP**라는 Python library를 사용하였다. Indy_utils의 설치 방법 및 사용방법 또한 아래의 IndyDCP에서 설명하겠다.



## 2. Algorithm

처음에 언급한 그림을 그리는 Manipulator를 구현하기 위해 사용한 Library 및 Algorithm에 대해 설명하겠다.

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



### 2) Coordinate Generate

먼저 ROS상의 좌표에 대해서 설명하겠다.

<p align="center">
<img src="https://user-images.githubusercontent.com/84506968/173516502-e679503f-b8ab-4c66-ad34-3b5d8ed337c7.png" width="400" height="400"/>
</p>	



위의 그림에서 각각의 축에 대해 증가함에 따라서 Robot의 위치가 결정된다.

좌표를 생성하기 위해 사용한 라이브러리는 openCV이다. 아래의 코드를 통하여 openCV를 설치할 수 있다.
```python
pip install opencv-python
```
좌표를 생성하는 방법은 다음과 같다.

먼저 좌표를 생성하기 위해서 opencv를 통해 그리고자 하는 이미지를 만들었다.



<p align="center">
<img src="https://user-images.githubusercontent.com/84506968/173518427-f26f41bd-4afd-4169-a353-9e04dc1cce3d.png" width="100" height="100"/>
</p>	

위와 같은 이미지 데이터를 통하여 좌표를 얻어냈다.

로봇에서 한 획별로 따로 동작을 해야하기 때문에 각각의 획별로 좌표 생성함수를 이용해 좌표를 추출한다.

원을 통해 좌표추출 방법을 설명하겠다.


<p align="center">
<img src="https://user-images.githubusercontent.com/84506968/173517584-9b43627b-a9da-45db-9ad8-1ea704f44768.png" width="600" height="300"/>
</p>	
이중 반복문을 통하여 가장 왼쪽의 점을 Detect한다. 그 이후 화살표방향으로 좌표값을 저장한다. 이 때에는 같은 x좌표의 경우에는 가장 y값이 큰 것을 선택한다. 이 때 반원의 좌표만을 저장한다.
다음 반복문에서는 나머지 반원의 좌표를 저장한다. 방법은 아래 반원과 유사하다.  

이렇게 정의한 함수의 사용예제는 다음과 같다.
```python
gen_rel_coordinate(img, 'circle')
gen_rel_coordinate_noncircle(img, 'circle')
```
[Coordinate Generate Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/Code/Coordinate%20Generator.ipynb)

이 코드는 Img데이터와 csv파일의 이름을 지정해주면 이에 해당하는 좌표를 지닌 csv파일을 생성해준다.
하지만 x축별로 한 값만을 지정하기 때문에 I의 형태는 좌표로 생성할 수 없는 문제가 존재한다.



### 3) Face Detection

Face Detection의 순서는 다음과 같다.

​		Step 1. Webcam을 사용하여 사람의 얼굴을 분석하고 Detect한다.

​		Step 2. 얼굴 부분이 Detect된 Bounding Box의 좌표를 얻어 원본이미지에서 얼굴 부분만 추출한다.

​		Step 3. Pre-Train 된 모델을 사용하여 사람의 표정을 7개의 종류 중 하나로 분석한다.



#### - Step 1

Webcam을 사용한 FaceDetection은 **MediaPipe**라는 Library에서 제공한다.  MediaPipe는 Python openCV 기반의 Library이기 때문에 Python openCV를 함께 설치 해주어야 한다. Coordinate Generate에 단계에서 openCV를 미리 설치해 두었기 때문에 Cmd창에서 아래와 같은 코드를 입력하여 Mediapipe만 설치한다.

```text
pip install mediapipe
```

MediaPipe Site: [MediaPipe Link](https://google.github.io/mediapipe/)

MediaPipe는 FaceDectect 이외에도 ObjectDetect, HandSkeleton 등 다양한 Pre-Train 된 Model을 제공한다.

Reference Link: [FaceDetection_Default](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/Code/face_detection_default.py)

위 링크는 MediaPipe에서 제공하는 파이썬 기반 FaceDetection의 초기 코드이다. 위 코드를 실행하면 미리 Pre-Train되어있기 때문에 얼굴 부분을 Detection해주는 것을 확인 할 수 있다.



#### - Step 2

MediaPipe는 Bounding Box의 좌표를 제공한다. 제공하는 좌표는 Bounding Box의 Xmin, Ymin, Width, height 총 4개의 좌표를 제공한다. 또한 0~1로 각 좌표들이 Normalize하여 제공하다.

```python
xmin = detection.location_data.relative_bounding_box.xmin * now_image.shape[1]
ymin = detection.location_data.relative_bounding_box.ymin * now_image.shape[0]
width = detection.location_data.relative_bounding_box.width * now_image.shape[1]
height = detection.location_data.relative_bounding_box.height * now_image.shape[0]
```

위 작업을 통해 Normailze된 좌표를 원래의 좌표로 수정하였다. eq) Image Size: 640X480



```python
left=int(xmin)
top=int(ymin)
right=int(xmin + width)
bottom=int(ymin + height)
```

위 작업을 통해 Bounding Box의 각 모서리 좌표를 얻었다. MediaPipe에서 제공하는 좌표값은 모두 float형태로 제공하기 때문에 Integer형태로 변화해 주었다.



```python
croppedImage = now_image[top:bottom, left:right]
```

위 작업을 통해 원본 Image에서 얼굴 부분만 추출했다.



#### - Step 3

얼굴 표정을 인식하는 딥러닝 모델은 **DeepFace**에서 제공하는 Model을 사용했다. DeepFace는 사람의 표정을 분석하여 총 7개의 표정에 대해 각각의 확률를 비교한 뒤 가장 높은 확률의 표정을 출력한다.

Deepface Library를 설치하는 방법은 cmd창에서 아래의 코드를 입력해주면 된다.   

```python
pip install deepface
```

DeepFace Github: [DeepFace Link](https://github.com/serengil/deepface)

DeepFace는 다양한 검증된 모델들을 wrapping하고 있는 경량의 하이브리드 face recognition 프레임워크이다. 또한 "VGG-Face", "Facenet", "Facenet512", "OpenFace", "DeepFace", "DeepID", "ArcFace", "Dlib", "SFace" 의 다양한 모델들을 제공한다. default는 VGG-Face를 제공한다.



```python
from deepface import DeepFace

obj = DeepFace.analyze(img_path = "example_Img.jpg", actions = ['emotion'], enforce_detection= False)

print(obj['dominant_emotion'])
```

위 코드를 입력하게 되면 example_Img에 대해서 표정을 분석하고 확률이 가장 높은 표정을 출력한다.  analyze 함수는 표정 뿐만아니라 표정에 대한 확률, 나이,  성별 등 다양한 값을 반환한다.

Reference Link: [Face Detection Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/Code/face_detect.py)

위 링크는 Step 1, 2, 3을 반영한 코드이다. 카메라가 켜진 상태에서 C를 누르게 되면 66프레임 이후 화면을 캡쳐하여 얼굴의 표정을 분석하는 방식이다.



## 3. Function

ROS 상에서 Drawing을 쉽게 하기 위해 정의한 함수들에 대해서 설명하겠다. 



### 1) draw_start()

Go board marker start position from home

```python
def draw_start():
```

**Example code**

```python
draw_start()
```



### 2) draw_csv()

Draw with coordinate CSV

```python
def draw_csv(name,ratio,resolution,directory):
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



### 3) go_home()

Code added with 'indy.go home()' function and avoid ROS command conflict

```python
def go_home():
```

**Example code**

```python
go_home()
```



## 4. Demonstration

### 1) [Demo Video](https://youtu.be/i0M4RSne7zU)

### 2) [Final Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/Code/Drawing.py)



## 5. Furtherwork

본 프로젝트에서 추가로 진행가능한 내용들은 다음과 같다.

1. **감정의 확률에 따른 이모티콘의 크기 조정해서 그리기**

   함수의 documentation을 보면 drawing하는 이모티콘의 size또한 input parameter로 정의된 것을 알 수 있다. 이를 활용하여 감정의 확률에 따라 이모티콘의 크기를 조정하는 것 또한 가능하다고 생각된다.

   하지만 여기에는 어려운점이 존재한다. indy_utils라이브러리에는 점들을 지정해줘서 로봇을 동작시킨다. 하지만 이 때 관절의 제한사항 때문에 이동하지 못하는 좌표가 존재한다. 이는 파이썬 코드상에서 error가 발생하는 것이 아니라 로봇과 pc간의 연결에 문제가 생긴다. 그렇기 때문에 파이썬 코드 상에서 except구문을 사용할 수 없었다. 이를 해결하기 위해서는 로봇의 move_to명령을 하기 이전에 충돌이 예상된다면, 해당 좌표로의 이동을 방지하는 코드가 필요할 것이다.



2. **캐리커쳐 그리기**

   이모티콘을 그리게 된 데에는 이유가 있다. 먼저 로봇에 곡선 형태의 움직임을 명령하는 법을 몰랐기 때문이다. 프로젝트 가장 첫 계획은 전이학습을 통한 캐리커쳐 이미지를 생성하고, 해당 이미지의 특징 경로들을 통하여 캐리커쳐를 그리는 것이었다.

   해당 과정이 성공하기 위해서 봐야할 라이브러리들은 다음과 같다.

   2.1 Pypotrace [pypotrace · PyPI](https://pypi.org/project/pypotrace/)

   ​	python 3.X.X버전에서 돌아가도록 한 라이브러리 [potrace/README.md at main · tatarize/potrace (github.com)](https://github.com/tatarize/potrace/blob/main/README.md)

   2.2 bezier curve움직임 명령 [ros-industrial-consortium/bezier: ROS-Industrial Special Project: 6D tool path planner (github.com)](https://github.com/ros-industrial-consortium/bezier)

   ​	Pypotrace를 통하여 이미지의 bezier curve를 얻어낼 수 있다. 

   ​	그리고 해당 곡선의 모양대로 움직이도록 하는 	라이브러리 또한 존재한다. 

   ​	두 라이브러리를 활용한다면 캐리커쳐 그리는 것도 가능할 것이다.
