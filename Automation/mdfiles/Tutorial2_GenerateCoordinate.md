

# Tutorial2 : Generate coordinate

본 튜토리얼은 로봇이 그리는 이모티콘의 좌표를 생성하는 튜토리얼이다.

### Overview

Face Detection의 순서는 다음과 같다.

Step 1. **openCV**로 이모티콘을 그린다.

Step 2. 정의된 함수로 이모티콘의 좌표들을 획별로 생성한다.

본 함수들을 보다 잘 이용하고 개선하기 위해서는 알고리즘의 설명 또한 필요하기에 해당 내용은 마지막에 서술하겠다.




### Step1 : 이모티콘 그리기
**openCV**의 ellipse, line, circle과 같은 함수들을 이용하여 이모티콘의 이미지를 생성한다.

```python
imge = np.ones((100, 100), dtype=np.uint8)*255 

cv2.circle(imge,(50,50),20,0)
cv2.circle(imge,(42,45),3,0)
cv2.circle(imge,(58,45),3,0)
cv2.ellipse(imge,(50,60),(10,6),0,10,170,1)
cv2.ellipse(imge,(50,60),(10,6),0,170,350,1)

cv2.imshow('imge',imge)

cv2.waitKey()
cv2.destroyAllWindows()
```

위의 코드의 imge는 웃는 이모티콘의 예시이다.

임의의 빈 이미지 파일을 생성하고, 해당 이미지에 CV함수를 통하여 원하는 이미지를 그린다.



### Step2 : 좌표생성
로봇이 움직일 때, 한 획을 그리고 펜을 뗀 후에 새로운 획을 그려야 하기 때문에 아래와 같은 방법으로 좌표를 생성한다.

```python
#놀람
imge = np.ones((100, 100), dtype=np.uint8)*255 
# cv2.circle(imge,(50,50),20,0)
# cv2.circle(imge,(42,45),3,0)
# cv2.circle(imge,(58,45),3,0)
# cv2.ellipse(imge,(50,60),(10,6),0,10,170,1)
cv2.ellipse(imge,(50,60),(10,6),0,170,350,1)

cv2.imshow('imge',imge)

cv2.waitKey()
cv2.destroyAllWindows()
```

먼저 위의 코드를 실행해 좌표를 저장하고자 하는 이미지를 생성 및 모양을 확인한다.

그 이후 아래의 함수를 활용하여 **좌표가 포함된 CSV파일**을 생성한다. 해당 **파일의 생성위치는 코드와 동일한 위치**에 생성된다.

```python
gen_rel_coordinate(imge, 'surprise_2')
gen_rel_coordinate_noncircle(imge,'surprise_4')
```

**Documentation**

**imge** : 좌표를 추출하고자 하는 이미지 (한 획만 포함되어야 함)

**'surprise_2'** : 저장하고자 하는 CSV파일의 이름 (string형태로 입력해야 함)

<br/>

### 전체 코드

본 코드는 **.ipynb**로 작성되었기 때문에 링크만 첨부하겠다.

**openCV**로 그려진 이미지들과 좌표를 생성하는 함수가 정의되어있다.

Whole code: [Coordinate Generate Code](https://github.com/jw-park-980508/Digital-Twin-Automation/blob/main/Automation/source/Coordinate%20Generator.ipynb)



### 알고리즘

<img src="https://user-images.githubusercontent.com/84506968/173517584-9b43627b-a9da-45db-9ad8-1ea704f44768.png" width="600" height="300"/>
</p>	
이중 반복문을 통하여 가장 왼쪽의 점을 Detect한다.

그 이후 화살표방향으로 좌표값을 저장한다. (이 때에는 같은 x좌표의 경우에는 가장 y값이 큰 것을 선택한다)

다음 반복문에서는 나머지 반원의 좌표를 저장한다.

**개선사항**: y값이 가장 큰 것만을 선택하기 생성되는 좌표로 그리는 이미지가 불균형할 수 있으며, 1자로 된 이미지가 존재한다면 한 점만 저장될수도 있다.