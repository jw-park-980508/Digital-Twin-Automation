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



## Face Detection

Face Detection의 순서는 다음과 같다.

​	Step 1. Webcam을 사용하여 사람의 얼굴을 분석하고 Detect한다.

​	Step 2. 얼굴 부분이 Detect된 Bounding Box의 좌표를 얻어 원본이미지에서 얼굴 부분만 추출한다.

​	Step 3. Pre-Train 된 모델을 사용하여 사람의 표정을 7개의 종류 중 하나로 분석한다.

### Step 1

Webcam을 사용한 FaceDetection은 **MediaPipe**라는 Library에서 제공한다.  MediaPipe는 Python openCV 기반의 Library이기 때문에 Python openCV를 함께 설치 해주어야 한다. Cmd창에서 아래와 같은 코드를 입력하여 두 Library를 설치한다.

```text
pip install mediapipe opencv-python
```

MediaPipe Link: https://google.github.io/mediapipe/ 
MediaPipe는 FaceDectect 이외에도 ObjectDetect, HandSkeleton 등 다양한 Pre-Train 된 Model을 제공한다. 

[Face Detection Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/face_detect.py)



### Function Name

```text

```

**Parameters**

* p1
* p2

**Example code**
