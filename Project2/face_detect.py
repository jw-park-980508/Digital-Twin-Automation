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
        
        ##### bounding box를 그려주는 건데 이미 라이브러리에서 제공함
        # cv2.line(image, (left, top), (right, top), (255,0,0), thickness=2)
        # cv2.line(image, (left, bottom), (right, bottom), (255,0,0), thickness=2)
        # cv2.line(image, (left, top), (left, bottom), (255,0,0), thickness=2)
        # cv2.line(image, (right, top), (right, bottom), (255,0,0), thickness=2)

        if keyboard.is_pressed("c"):
          print('pressed c')
          Flag = True

        if Flag == True:
          person_sec += 1 #사람이 detection된 프레임의 수 1초에 33 frame
          print('person_sec: ',person_sec)

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

    else:
      person_sec = 0
      Flag = False

    # Flip the image horizontally for a selfie-view display.
    cv2.imshow('MediaPipe Original Detection', cv2.flip(croppedImage, 1))
    cv2.imshow('MediaPipe Face Detection', cv2.flip(image, 1))
    if cv2.waitKey(5) & 0xFF == 27:
      break
cap.release()