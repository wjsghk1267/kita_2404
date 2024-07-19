from flask import Flask, render_template, jsonify
import pandas as pd
import json

app = Flask(__name__)

# CSV 파일에서 데이터 로드
df = pd.read_csv('static/yes24.csv')

# 예시: 연령대별 선호 카테고리 데이터 가공
def get_age_preferences(age):
    age_data = df[df['Age'] == age]
    preferences = age_data['Category'].value_counts().head(5)
    return preferences

# 웹 페이지 렌더링
@app.route('/')
def index():
    return render_template('index.html')

# 연령대에 따른 데이터 제공 API
@app.route('/get_visualization')
def get_visualization():
    age = request.args.get('age', type=int)
    
    # 연령대별 선호 카테고리 데이터 가져오기
    preferences = get_age_preferences(age)
    
    # 데이터를 JSON 형식으로 변환하여 전송
    chart_data = {
        'labels': preferences.index.tolist(),
        'values': preferences.values.tolist()
    }
    
    return jsonify(chart_data)

if __name__ == '__main__':
    app.run(debug=True)
