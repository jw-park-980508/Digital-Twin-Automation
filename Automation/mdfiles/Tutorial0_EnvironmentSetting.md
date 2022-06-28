# Tutorial0 : Environment setting

본 튜토리얼은 VS code, Anaconda, python library를 설치하기 위한 튜토리얼이다.

### Install visual studio code

   - **VScode**는 윈도우, 맥, 리눅스에서 사용가능한 코드 편집기이다.
   - 다음의 주소를 통해 **VScode**를 설치할 수 있다 [Install Link](https://code.visualstudio.com/Download)





### Install Anaconda
   - **Anaconda**는 파이썬 가상환경을 통하여 라이브러리들을 설치 및 관리할 수 있게 하는 도구이다.
   - 다음의 주소를 통해 **VScode**를 설치할 수 있다 [Install Link](https://www.anaconda.com/products/distribution#download-section)


![image](https://user-images.githubusercontent.com/84506968/176124514-1a0ec6cc-c4b7-460d-b18d-ce078bd05aa2.png)**Anaconda**가 잘 설치되었다면 윈도우 검색기능을 통하여 **Anaconda Prompt**를 찾을 수 있다.

가상환경을 설치하기 위해 해당 파일을 관리자 권한으로 실행한다.


   - 가상환경 생성

```text
conda create -n py37 python = 3.7.13
```



### Install Python modules
본 프로젝트를 위해서는 다음과 같은 라이브러리들이 필요하다.
(openCV, mediapipe, deepface, keyboard, pandas, numpy)

   - 가상환경 접근

```text
conda activate py37
```

![image](https://user-images.githubusercontent.com/84506968/176129451-1482f9b1-c18b-4851-9aa9-fb8c137f4252.png)

이 때, 위의 사진처럼 **conda prompt** 가장 왼쪽의 괄호이름이 **py37**로 변경되었는지 확인하고 진행해야 한다.

   - 라이브러리 설치 : 가상환경 접근 이후, 1줄씩 입력해 라이브러리를 설치 가능하다.
```text
pip install opencv-python
pip install mediapipe
pip install deepface
pip install keyboard
pip install pandas
pip install numpy
```
