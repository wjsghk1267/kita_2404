import pandas as pd
import numpy as np
#Task1_0528. 연산메소드 이용 및 NaN 값을 0으로 대체 후 사칙연산을 
# 수행한 후 결과를 출력하세요. 

st1 = pd.Series({'국어':np.nan,'영어':80,'수학':90})
st2 = pd.Series({'수학':80,'국어':90})

add = st1 + st2
sub = st1 - st2
mul = st1 * st2
div = st1.div(st2, fill_value= 0)

result = pd.DataFrame([add,sub,mul,div],
                     index=['덧셈','뺄셈','곱셈','나눗셈'])

ad = st1.add(st2, fill_value = 0).astype(int)
su = st1.sub(st2, fill_value = 0).astype(int)
mu = st1.mul(st2, fill_value = 0).astype(int)
di = st1.div(st2, fill_value = 0)

df = pd.DataFrame([ad,su,mu,di], index=['덧셈','뺄셈','곱셈','나눗셈'])
print(df)


#%% Task2_0528. 주어진 DataFrame의 N열에서 Series s값을 빼고 
# 결과를 새로운 열 O에 저장 후 출력하세요.
import pandas as pd

# 데이터프레임 생성
df = pd.DataFrame({
    "M": [15, 25, 35, 45, 55],
    "N": [100, 200, 300, 400, 500]
})
s = pd.Series([5, 10, 15, 20, 25])

df['O'] = df['N'].sub(s)
print(df)      

#%% Task3_0528. 주어진 DataFrame의 여러 열에 대해 각기 다른 Series를 더하고, 
# 결과를 새로운 DataFrame으로 반환한 후 각 행의 합계를 계산하여 새로운 열에 추가하여 출력하세요.

import pandas as pd

# 데이터프레임 생성
df = pd.DataFrame({
    "A": [1, 2, 3, 4, 5],
    "B": [10, 20, 30, 40, 50],
    "C": [100, 200, 300, 400, 500]
})

# Series 생성
s1 = pd.Series([5, 5, 5, 5, 5])
s2 = pd.Series([10, 10, 10, 10, 10])
s3 = pd.Series([15, 15, 15, 15, 15])

df2 = pd.DataFrame({
    "a": df['A'].radd(s1),
    "b": df['B'].radd(s2),
    "c": df['C'].radd(s3),
    })

df2.index = [1,2,3,4,5]
df2['total'] = df2.sum(axis=1)

print(df2)

#%% Task4_0528. df에서 세 열의 값을 더하여 새로운 컬럼을 생성한 후 출력하세요.
import pandas as pd

# 데이터프레임 생성
df = pd.DataFrame({
    "A": [10, 20, 30, 40, 50],
    "B": [1, 2, 3, 4, 5],
    "C": [5, 10, 15, 20, 25],
    "D": [3, 6, 9, 12, 15],
    "E": [2, 4, 6, 8, 10]
})

df['F'] = df['A'] + df['B'] + df['C']
# df['F'] = df[['A','B','C']].sum(axis=1)

print(df)

#%% Task5_0528. df에서 세 열의 값을 평균하여 새로운 컬럼을 생성 후 출력하세요.
import pandas as pd

# 데이터프레임 생성
df = pd.DataFrame({
    "A": [100, 200, 300, 400, 500],
    "B": [10, 20, 30, 40, 50],
    "C": [1, 2, 3, 4, 5],
    "D": [7, 8, 9, 10, 11],
    "E": [3, 6, 9, 12, 15]
})


df['C:E 평균'] = round(df[['C','D','E']].mean(axis=1),2)
print(df)


#%% Task6_0528. df에서 두 개의 열을 더한 값이 다른 한 개의 열보다 큰 경우에는 1,
 # 작은 경우에는 0으로 값을 정하는 새로운 열을 생성한 후 출력하세요.

import pandas as pd

# 데이터프레임 생성
df = pd.DataFrame({
    "A": [2, 3, 4, 5, 6],
    "B": [1, 2, 3, 4, 5],
    "C": [3, 4, 5, 6, 7],
    "D": [8, 9, 10, 11, 12],
    "E": [10, 20, 30, 40, 50]
})

df['result'] = (df[['A','B']].sum(axis=1) > df['C']).astype(int)
 
print(df)
