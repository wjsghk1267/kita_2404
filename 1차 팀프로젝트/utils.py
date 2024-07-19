import pandas as pd

# 데이터프레임 로드
df = pd.read_csv('static/yes24_bestseller_data_final.csv')

def get_book_recommendations(gender, age):
    # 성별 필터링
    if gender == 'male':
        gender_filtered_df = df[df['Gender'] == 0]
    elif gender == 'female':
        gender_filtered_df = df[df['Gender'] == 1]
    else:
        return "잘못된 성별 입력입니다."

    # 나이 필터링
    age_filtered_df = gender_filtered_df[gender_filtered_df['Age'] == (age // 10) * 10]

    # 카테고리별 평균 판매 지수 계산
    top_category = age_filtered_df.groupby('Category')['Sales_Index'].mean().idxmax()

    # 해당 카테고리에서 가장 높은 판매 지수를 가진 도서 추천
    top_book = age_filtered_df[age_filtered_df['Category'] == top_category].sort_values('Sales_Index', ascending=False).iloc[0]

    return f"제목: {top_book['Title']} 작가: {top_book['Author']} 카테고리: {top_category}"