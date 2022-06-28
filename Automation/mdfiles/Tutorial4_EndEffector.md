

# Tutorial4 : End-Effector 보조 하드웨어

본 튜토리얼은 End-Effector 보조 하드웨어를 3D프린터로 출력하기 위해 필요한 튜토리얼이다.
편의상 End-Effector라 칭하겠다. 


### Overview

End-Effector 보조 하드웨어의 순서는 다음과 같다.

Step 1. End-Effector의 필요성

Step 2. End-Effector 제작

Step 3. 주의사항




### Step1 : End-Effector의 필요성


![image](https://user-images.githubusercontent.com/107538917/176117430-a811b802-eda9-4ee8-b868-ccaf4cb71e8f.png)

위 그림은 로봇 팔이 좌표를 이동하는 그림이다. 그림에서 확인할 수 있듯이 로봇팔이 포물선을 그리면서 이동한다. 
이 경우 이모티콘이 점으로 그려진다.(점묘화) 이를 방지하고자 End Effector가 제작되었다. 
따라서 본 End-Effector의 목적은 펜이 바닥과 떨어지는 것을 최대한 방지하는 것이다.



### Step2 : End-Effector 제작
총 **3개의 part**로 구성되어 있다.


아래 그림들(PART1,2,3)은 End-Effector를 구성하는 부품들이다.


![image](https://user-images.githubusercontent.com/107538917/176122614-a32a7bd9-3c5f-4ab9-9bbf-aadd73cfe543.png)

Part1과 Par2에는 스프링이 연결되어 완충역할을 하며, Part3은 커버 역할을 한다.



![image](https://user-images.githubusercontent.com/107538917/176122881-5d63c925-d5b8-4d0f-883c-156e7bd6552a.png)


위 그림은 3개 파트 및 스프링과 펜의 연결 분해도이다. 
part1과 part2는 스프링으로 서로 연결되어 있으며 글루건을 이용하여 펜이 파트2에 완전히 고정되어 있다. 
그리고 part3을 씌워주면 하드웨어 조립은 끝이다.

이 부품의 **원리**는 간단하다.
로봇 팔이 잡는 부분은 part1과 part3과 part2은 스프링으로 연결되어 있다. 따라서 로봇 팔이 일정 범위(스프링의 가동범위 내)내 움직여도 펜이 바닥에서 떨어지지 않을 수 있다.  


각 부품들은 **Solidworks**을 이용하여 디자인하였고, **3D print**로 출력하였다. 
용의한 수정을 위해서 보드 마카와 화이트 보드를 사용하였으며, 시중 볼펜의 일부부품인 스프링을 사용하였다.
자세한 치수는 프로그램으로 확인해 보길 바람.

[Modeling File Link](https://github.com/jw-park-980508/Digital-Twin-Automation/tree/main/Automation/hardware)

### Step3 : 주의사항
- 그림이 그려지는 보드가 수평이 맞춰져야 End-Effector가 제 역할을 다 할 수 있다. 
- 본 코드는 z축 좌표가 고정되어 있다. 만약 보드의 수평이 맞지 않을 경우 점으로 이모티콘이 그려지거나 펜의 촉이 휘어지는 불상사가 발생할 수 있음.
- 이를 방지하기 위해서 스프링의 길이를 늘리것도 방법이다. 
