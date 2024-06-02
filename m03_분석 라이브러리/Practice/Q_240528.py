# 데이터프레임 생성(8행 5열)
import numpy as np
import pandas as pd


# Q. df1으로 데이터프레임을 생성한 후 set_index를 사용하여 ID를 
# 인덱스 설정한 데이터프레임을 출력하세요.

df1 = pd.DataFrame({
    'ID': [101, 102, 103, 104],
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [24, 27, 22, 32]})
index={0:101,1:102,2:103,3:104}
df.rename(index=index, inplace = True)
print(df1)


#teach
df1.set_index('ID', inplace = True)
print('ID를 인덱스로 설정한 DF : \n', df1)

#%% Q. df2에 대해서 다음을 수행하세요.
# - set_index를 사용하여 인덱스를 설정.
# - reset_index를 사용하여 인덱스를 리셋.
df2 = pd.DataFrame({
    'ID': [101, 102, 103, 104],
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [24, 27, 22, 32]
})

df_set_index = df2.set_index('ID')
df_set_index

df_reset_index = df_set_index.reset_index()
df_reset_index

#teach


df2.set_index(inplace = True)
print('ID를 인덱스로 설정한 DF : \n', df2)
df2.reset_index(inplace = True)
print('\n인덱스를 리셋한 데이터프레임 : \n', df2)

#%% Q. df3에 대해서 reindex를 사용하여 인덱스를 변경하여 출력하세요.

df3 = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [24, 27, 22, 32]
}, index=[101, 102, 103, 104])

new_index = [102,101,104,103,105,106]
df_reindexed = df3.reindex(new_index)
df_reindexed


#%% Q. df4에 대해서 reindex를 사용하여 인덱스를 변경하고 결측치를 0으로
 # 채운 데이터프레임을 출력하세요.
 
df4 = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [24, 27, 22]
}, index=[0, 1, 2])

new_index = [0,1,2,3,4,5]
df_reindexed = df4.reindex(new_index, fill_value = 0)
df_reindexed



#%% Q. df5에서 reindex를 사용하여 특정 날짜 범위로 인덱스를 재설정하여 출력하세요.
dates = pd.date_range('2024-01-01', periods=4, freq='D')
df5 = pd.DataFrame({
    'Value': [10, 20, 30, 40]
}, index=dates)

new_dates = pd.date_range('2024-05-01', periods=6, freq='D')
df_reindex = df5.reindex(new_dates, method='ffill')

df_reindex

# teach
new_dates = pd.date_range('2024-01-01', periods=6, freq='D')
df_reindexed = df5.reindex(new_dates, fill_value = 10)
print(df_reindexed)

#%% Q. 데이터프레임 df6를 전치하고, 전치된 데이터프레임을 정리하여 연도별 
# 판매량 데이터를 제품별로 나열하여 출력하세요.
data = {
    'Year': ['2020', '2021', '2022'],
    'Product_A': [500, 600, 700],
    'Product_B': [400, 500, 600],
    'Product_C': [300, 400, 500]
}
df6 = pd.DataFrame(data)
# df6_t = df6.T
# df6_t

# teach
df_transposed = df6.set_index('Year').T
print(df_transposed)


df_transposed.reset_index(inplace = True)
df_transposed.rename(columns=['index':'Product'], inplace = True)
print('정리된 전치 데이터 프레임:\n',df_transposed)