import cv2
import keyboard

from indy_utils import indydcp_client as client
from indy_utils.indy_program_maker import JsonProgramComponent

import json
import threading
from time import sleep
import numpy as np
import pandas as pd

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

size = 0.005
emotion = 'happy'

if emotion == 'angry':
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

elif emotion == 'disgust':
  draw_start()
  draw_csv('circle_rel',size,1)
  print('draw circle_rel done')

  draw_start()
  draw_csv('disgust_1_rel',size,1,emotion)
  print('draw disgust1 done')

  draw_start()
  draw_csv('disgust_2_rel',size,1,emotion)
  print('draw disgust2 done')

  draw_start()
  draw_csv('disgust_3_rel',size,1,emotion)
  print('draw disgust3 done')

  go_home()

elif emotion == 'fear':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('fear_1_rel',size,1,emotion)
  print('draw fear1 done')

  draw_start()
  draw_csv('fear_2_rel',size,1,emotion)
  print('draw fear2 done')

  draw_start()
  draw_csv('fear_3_rel',size,1,emotion)
  print('draw fear3 done')
  
  draw_start()
  draw_csv('fear_4_rel',size,1,emotion)
  print('draw fear4 done')

  draw_start()
  draw_csv('fear_5_rel',size,1,emotion)
  print('draw fear5 done')

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
  print('draw neutral1 done')

  draw_start()
  draw_csv('neutral_2_rel',size,1,emotion)
  print('draw neutral2 done')

  draw_start()
  draw_csv('neutral_3_rel',size,1,emotion)
  print('draw neutral3 done')

  go_home()

elif emotion == 'sad':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('sad_1_rel',size,1,emotion)
  print('draw sad1 done')

  draw_start()
  draw_csv('sad_2_rel',size,1,emotion)
  print('draw sad2 done')

  draw_start()
  draw_csv('sad_3_rel',size,1,emotion)
  print('draw sad3 done')
  
  draw_start()
  draw_csv('sad_4_rel',size,1,emotion)
  print('draw sad4 done')

  draw_start()
  draw_csv('sad_5_rel',size,1,emotion)
  print('draw sad5 done')

  draw_start()
  draw_csv('sad_6_rel',size,1,emotion)
  print('draw sad6 done')
  
  draw_start()
  draw_csv('sad_7_rel',size,1,emotion)
  print('draw sad7 done')

  go_home()

elif emotion == 'surprise':
  draw_start()
  draw_csv('circle_rel',size,1,emotion)
  print('draw circle_rel done')

  draw_start()
  draw_csv('surprise_1_rel',size,1,emotion)
  print('draw surprise1 done')

  draw_start()
  draw_csv('surprise_2_rel',size,1,emotion)
  print('draw surprise2 done')

  draw_start()
  draw_csv('surprise_3_rel',size,1,emotion)
  print('draw surprise3 done')
  
  draw_start()
  draw_csv('surprise_4_rel',size,1,emotion)
  print('draw surprise4 done')

  go_home()
  
indy.disconnect()