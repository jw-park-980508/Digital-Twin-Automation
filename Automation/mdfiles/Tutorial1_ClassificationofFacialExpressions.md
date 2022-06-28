

# Tutorial1 : Classification of facial expressions


### Overview

Face Detection의 순서는 다음과 같다.

Step 1. Mediapipe를 통해 얼굴부분의 bounding box를 캡쳐한다.

Step 2. Deepface를 통해 표정을 분석한다.






### Step1 : 얼굴부분 boundig box이미지 생성
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





### Step2 : Deepface를 통한 표정분석
얼굴 표정을 인식하는 딥러닝 모델은 **DeepFace**에서 제공하는 Model을 사용했다. DeepFace는 사람의 표정을 분석하여 총 7개의 표정에 대해 각각의 확률를 비교한 뒤 가장 높은 확률의 표정을 출력한다.

DeepFace는 다양한 검증된 모델들을 wrapping하고 있는 경량의 하이브리드 face recognition 프레임워크이다. 또한 "VGG-Face", "Facenet", "Facenet512", "OpenFace", "DeepFace", "DeepID", "ArcFace", "Dlib", "SFace" 의 다양한 모델들을 제공한다. default는 VGG-Face를 제공한다.

DeepFace Github: [DeepFace Link](https://github.com/serengil/deepface)

```python
from deepface import DeepFace

obj = DeepFace.analyze(img_path = "example_Img.jpg", actions = ['emotion'], enforce_detection= False)

print(obj['dominant_emotion'])
```

위 코드를 입력하게 되면 example_Img에 대해서 표정을 분석하고 확률이 가장 높은 표정을 출력한다.  analyze 함수는 표정 뿐만아니라 표정에 대한 확률, 나이,  성별 등 다양한 값을 반환한다.

<br/>

### 전체 코드

위의 step1과 step2가 적용된 전체 코드는 다음과 같다.

```python
import cv2
import mediapipe as mp
import keyboard
from deepface import DeepFace

mp_face_detection = mp.solutions.face_detection
mp_drawing = mp.solutions.drawing_utils
person_sec = 0
Flag = False

# For webcam input:
cap = cv2.VideoCapture(0)
with mp_face_detection.FaceDetection(
    model_selection=0, min_detection_confidence=0.5) as face_detection:
  while cap.isOpened():
    success, image = cap.read()
    now_image = image           #현재 프레임의 이미지를 저장함, 아래의 pooling과정에서 image를 바꾸기 때문 
    if not success:
      print("Ignoring empty camera frame.")
      # If loading a video, use 'break' instead of 'continue'.
      continue

    # To improve performance, optionally mark the image as not writeable to
    # pass by reference.
    image.flags.writeable = False
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)  #OpenCV에서 이미지를 처리하기 위해서는 BGR -> RGB
    results = face_detection.process(image)

    # Draw the face detection annotations on the image.
    image.flags.writeable = True
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)  #정상적인 이미지를 보기위해 RGB -> BGR
    if results.detections:
      for detection in results.detections:
        mp_drawing.draw_detection(image, detection)

        #각각의 좌표는 0~1로 이미지의 크기 640X480으로 normalize 되어있음 
        #float 형태로 제공
        xmin = detection.location_data.relative_bounding_box.xmin * now_image.shape[1]
        ymin = detection.location_data.relative_bounding_box.ymin * now_image.shape[0]
        width = detection.location_data.relative_bounding_box.width * now_image.shape[1]
        height = detection.location_data.relative_bounding_box.height * now_image.shape[0]

        left=int(xmin) 
        top=int(ymin) 
        right=int(xmin + width )
        bottom=int(ymin + height)
        
        #bounding box의 부분만 가져옴
        croppedImage = now_image[top:bottom, left:right]

        if keyboard.is_pressed("c"):
          print('pressed c')
          Flag = True

        if Flag == True:
          person_sec += 1 #사람이 detection된 프레임의 수 1초에 33 frame
          print('person_sec: ',person_sec)
          
    else:
      person_sec = 0
      Flag = False

    if person_sec == 66:
          Flag = False
          save_image = croppedImage
          person_sec = 0
          print('Image Captured!')
          
          try:
              obj = DeepFace.analyze(img_path = save_image, actions = ['emotion'], enforce_detection= False)
              print('Probability =',obj['emotion'][obj['dominant_emotion']])
              print(obj['dominant_emotion'])
          except:
              print('image should be clear')
          
          break
            
    # Flip the image horizontally for a selfie-view display.
    cv2.imshow('MediaPipe Original Detection', cv2.flip(croppedImage, 1)) #카메라 끄는 것으로
    cv2.imshow('MediaPipe Face Detection', cv2.flip(image, 1))
    if cv2.waitKey(5) & 0xFF == 27:
      break
cap.release()
```

Whole code: [Face Detection Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/Code/face_detect.py)