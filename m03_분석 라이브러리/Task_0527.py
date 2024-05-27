# =============================================================================
# Task1_0527. 4개의 Series를 결합하여 데이터프레임을 생성하여 출력하세요.
# - 출력한 데이터프레임에서 추출하고 싶은 5개의 데이터를 인덱싱하여 출력
# - null값을 3개 추가
# - null값의 개수를 확인하고 삭제
# - 2개의 데이터를 수정
# - 1개의 행을 삭제
# =============================================================================
import pandas as pd
import numpy as np

df = pd.DataFrame({
    "Name": ["Alice", "Bob", "Charlie", "David", "Eve"],
    "Age": [18, 19, 20, 21, 22],
    "Gender": ['F', 'M', 'M', 'M', 'F'],
    "Height": [168, 190, 175, 179, 162],
    "Weight": [60, 90, 80, 78, 50]
})

df.loc[(df['Gender'] == 'F') & (df['Weight'] >= 60), 'Weight'] = np.nan
df.loc[(df['Gender'] == 'M') & (df['Height'] <= 180), 'Height'] = np.nan
print(df,'\n')
null_cnt = df.isnull().sum()
print(f'null 개수 : {sum(null_cnt)}')
print()
df.dropna(inplace=True)
print(df,'\n')
df.iloc[0, 1] = 12
df.loc[df['Name'] == 'Eve', 'Age'] = 10
print(df,'\n')
df.drop(1, inplace=True)
print(df)


#%% Task2_0527. 학생별 성적 데이터셋으로 의미있게 데이터 셋을 수정하세요.(아래 사항 반영)
# - S1 ~ S10은 평균 점수를 기준으로 1등급에서 10등급이고 등급간 점수 차는 5점
# - 결시자가 국어 3명, 수학 2명 있음
# - 영어, 수학의 평균 점수가 국어 대비 5점 낮음
# =============================================================================
import pandas as pd
import numpy as np
import random

np.random.seed(0)
df = np.random.randint(1,5,size=(10,5))
df=pd.DataFrame(df,index=['s1','s2','s3','s4','s5','s6','s7','s8','s9','s10'],
               columns=['국어','영어','수학','과학','사회'])


print(df)

#%% Task3_0527. df1에서 결측값 처리 후 딕셔너리, 리스트로 변환하여 출력하세요.
df1 = pd.DataFrame({
    "Name": ["Alice", "Bob", "Charlie", "David", "Eve"],
    "Math": [85, np.nan, 88, 90, 76],
    "English": [92, 85, 89, np.nan, 80],
    "Science": [78, 90, 95, 85, 89],
    "History": [88, 92, 85, 91, np.nan]
})
df1.dropna(inplace=True)

ar = df1.values
li = ar.tolist()
print(li,'\n')
dict = df1.to_dict('list')
print(dict)


#%% =============================================================================
# Task4_0527. df2에서 아래와 같이 데이터 필터링 및 정렬 후 배열, 딕셔너리, 리스트로 변환하여 출력하세요.
# - Math 점수가 80 이상인 학생만 선택
# - English 점수를 기준으로 내림차순 정렬
# =============================================================================
df2 = pd.DataFrame({
    "Name": ["Alice", "Bob", "Charlie", "David", "Eve"],
    "Math": [85, 79, 88, 90, 76],
    "English": [92, 85, 89, 93, 80],
    "Science": [78, 90, 95, 85, 89],
    "History": [88, 92, 85, 91, 84]
})

result = df2.loc[df2['Math'] >= 80]
sorted_result = result.sort_values(by='English', ascending=False)

print(sorted_result)


#%% Task5_0527. df3에서 각 학생의 평균 점수 계산 후 배열, 딕셔너리, 리스트로 변환하여 출력하세요.
df3 = pd.DataFrame({"Name": ["Alice", "Bob", "Charlie", "David", "Eve", "Alice", "Bob", "Charlie", "David", "Eve"],
    "Subject": ["Math", "Math", "Math", "Math", "Math", "English", "English", "English", "English", "English"],
    "Score": [85, 79, 88, 90, 76, 92, 85, 89, 93, 80]
})

avg = df3.groupby("Name")["Score"].mean()
print(avg)


#%% Task6_0527. df4에서 특정 열의 데이터 타입을 변환한 후 변환된 타입을 확인하세요.
df4 = pd.DataFrame({
    'A': ['1', '2', '3', '4'],
    'B': ['5.1', '6.2', '7.3', '8.4'],
    'C': ['2021-01-01', '2021-02-01', '2021-03-01', '2021-04-01']
})

print(df4,'\n')

print(df4.values.tolist(),type(li),'\n')

print(df4.to_dict('list'),type(dict))


#%% Task7_0527. df5에서 나이가 25 이상인 행을 출력하세요.
df5 = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie', 'David', 'Eve'],
    'Age': [24, 27, 22, 32, 29],
    'City': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix']
})

result = df5.loc[df5['Age'] >= 25]

print(result)
