# Automation

## Introduction

이 Respository는 2202년도 1학기에 Digital Twin & Automation 수업의 Automation Part의 내용이다.

우리는 카메라를 사용하여 사람의 표정을 angry, disgust, fear, happy, sad, surprise, neutral 총 7개의 표정으로 분석하고 Manipulator를 사용하여 표정에 대한 이모티콘을 그려주는 프로젝트를 진행했다.

### Flow Chart

아래 그림과 같은 순서로 프로젝트를 진행했다. 

![image](https://user-images.githubusercontent.com/84221531/173183973-03166869-b47f-462b-9c62-51cc6ae1c226.png)



### HardWare


매니퓰레이터 모델은 **INDY-10 (Neuromeka)**로 로봇 제어를 위한 indy XX library를 사용했다.



### SoftWare

또한 표정 분석을 위해 mediapipe library 및 DeepFace library를 사용했다. 두 library의 설치 방법 및 사용방법은 아래의 Face Detection Part에서 설명하겠다.



## Coordinate Generate
먼저 ROS상의 좌표에 대해서 설명하겠다.

좌표를 생성하는 방법은 다음과 같다.


## Face Detection

Face Detection의 순서는 다음과 같다.

​		Step 1. Webcam을 사용하여 사람의 얼굴을 분석하고 Detect한다.

​		Step 2. 얼굴 부분이 Detect된 Bounding Box의 좌표를 얻어 원본이미지에서 얼굴 부분만 추출한다.

​		Step 3. Pre-Train 된 모델을 사용하여 사람의 표정을 7개의 종류 중 하나로 분석한다.

### Step 1

Webcam을 사용한 FaceDetection은 **MediaPipe**라는 Library에서 제공한다.  MediaPipe는 Python openCV 기반의 Library이기 때문에 Python openCV를 함께 설치 해주어야 한다. Cmd창에서 아래와 같은 코드를 입력하여 두 Library를 설치한다.

```text
pip install mediapipe opencv-python
```

MediaPipe Site: [MediaPipe Link](https://google.github.io/mediapipe/)

MediaPipe는 FaceDectect 이외에도 ObjectDetect, HandSkeleton 등 다양한 Pre-Train 된 Model을 제공한다.

Reference Link: [FaceDetection_Default](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/face_detection_default.py)

위 링크는 MediaPipe에서 제공하는 파이썬 기반 FaceDetection의 초기 코드이다. 위 코드를 실행하면 미리 Pre-Train되어있기 때문에 얼굴 부분을 Detection해주는 것을 확인 할 수 있다.



### Step 2

MediaPipe는 Bounding Box의 좌표를 제공한다. 제공하는 좌표는 Bounding Box의 Xmin, Ymin, Width, height 총 4개의 좌표를 제공한다. 또한 0~1로 각 좌표들이 Normalize하여 제공하다.

```python
xmin = detection.location_data.relative_bounding_box.xmin * now_image.shape[1]
ymin = detection.location_data.relative_bounding_box.ymin * now_image.shape[0]
width = detection.location_data.relative_bounding_box.width * now_image.shape[1]
height = detection.location_data.relative_bounding_box.height * now_image.shape[0]
```

위 작업을 통해 Normailze된 좌표를 원래의 좌표로 수정하였다. eq) Image Szie: 640X480



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



### Step 3

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

Reference Link: [Face Detection Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/face_detect.py)

위 링크는 Step 1, 2, 3을 반영한 코드이다.



### Function Name

```text

```

* 

**Example code**
