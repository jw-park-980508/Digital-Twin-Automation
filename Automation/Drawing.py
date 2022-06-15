import cv2
import mediapipe as mp
from deepface import DeepFace
import keyboard

from indy_utils import indydcp_client as client
from indy_utils.indy_program_maker import JsonProgramComponent

import json
import threading
from time import sleep
import numpy as np
import pandas as pd

mp_face_detection = mp.solutions.face_detection
mp_drawing = mp.solutions.drawing_utils
person_sec = 0
Flag = False

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

def go_home():
    indy.go_home()

    while True:
        status = indy.get_robot_status()
        sleep(0.2)
        if status[key[5]]==1 :
            break
    print("done go home")
    return None

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
    max_area = 0
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
        
        if left < 0:
          left = 0
        if top < 0:
          top = 0
          
        now_area = (abs(top-bottom))*(abs(right-left))
        #bounding box의 부분만 가져옴
        if now_area >= max_area :
          croppedImage = now_image[top:bottom, left:right]
          max_area = now_area

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
              obj1 = DeepFace.analyze(img_path = save_image, actions = ['emotion'], enforce_detection= False)
              print('Probability =',obj1['emotion'][obj1['dominant_emotion']])
              print(obj1['dominant_emotion'])
              cap.release()
              # break

          except:
              print('image should be clear')
              cap.release()
              break
            
    # Flip the image horizontally for a selfie-view display.
    # cv2.imshow('MediaPipe Original Detection', cv2.flip(croppedImage, 1)) #카메라 끄는 것으로
    cv2.imshow('MediaPipe Face Detection', cv2.flip(now_image, 1))
    if cv2.waitKey(5) & 0xFF == 27:
      break
cap.release()

robot_ip = "192.168.0.6"  # Robot (Indy) IP
robot_name = "NRMK-Indy10"  # Robot name (Indy7)indy

# Create class object
indy = client.IndyDCPClient(robot_ip, robot_name)

indy.connect()

indy.set_collision_level(5)
indy.set_joint_vel_level(7)
indy.set_task_vel_level(7)
indy.set_joint_blend_radius(20)
indy.set_task_blend_radius(0.2)

print(indy.get_collision_level())
print(indy.get_joint_vel_level())
print(indy.get_task_vel_level())
print(indy.get_joint_blend_radius())
print(indy.get_task_blend_radius())

j_pos = indy.get_joint_pos()
t_pos = indy.get_task_pos()

print(j_pos)
print(t_pos)

key = []
status = indy.get_robot_status()
for value in status.keys():
    key.append(value)
    
print(key)
print(type(status))
    


indy.go_home()

while True:
    status = indy.get_robot_status()
    sleep(0.2)
    if status[key[5]]==1 :
        break

print('done : go home process')


print('Probability =',obj1['emotion'][obj1['dominant_emotion']])
print(obj1['dominant_emotion'])

emotion = obj1['dominant_emotion']
probability = obj1['emotion'][obj1['dominant_emotion']]
# if probability>50:
#   size = 0.005
# else :
#   size = 0.004

# emotion = 'surprise'
size = 0.005

if emotion == 'angry':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('angry_1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('angry_2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('angry_3_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()

elif emotion == 'disgust':
  draw_start()
  draw_csv('circle_rel',size,1)
  print('draw circle_rel done')

  draw_start()
  draw_csv('disgust_1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('disgust_2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('disgust_3_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()

elif emotion == 'fear':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('fear_1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('fear_2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('fear_3_rel',size,1,emotion)
  print('draw happy3 done')
  
  draw_start()
  draw_csv('fear_4_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('fear_5_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()

elif emotion == 'happy':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('happy1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('happy2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('happy3_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()

elif emotion == 'neutral':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('neutral_1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('neutral_2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('neutral_3_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()

elif emotion == 'sad':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('sad_1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('sad_2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('sad_3_rel',size,1,emotion)
  print('draw happy3 done')
  
  draw_start()
  draw_csv('sad_4_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('sad_5_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('sad_6_rel',size,1,emotion)
  print('draw happy3 done')
  
  draw_start()
  draw_csv('sad_7_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()

elif emotion == 'surprise':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('surprise_1_rel',size,1,emotion)
  print('draw happy1 done')

  draw_start()
  draw_csv('surprise_2_rel',size,1,emotion)
  print('draw happy2 done')

  draw_start()
  draw_csv('surprise_3_rel',size,1,emotion)
  print('draw happy3 done')
  
  draw_start()
  draw_csv('surprise_4_rel',size,1,emotion)
  print('draw happy3 done')

  go_home()
  
indy.disconnect()