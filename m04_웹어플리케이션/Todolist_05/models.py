
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy() # db <-> app객체 연동, 연계 (서버랑 상호 쓰고읽기)

class Task(db.Model): # DB에서 Table 구성. 파일(칼럼)들을 관리. 각 칼럼에 맞는 타입,요건 정의
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    contents = db.Column(db.Text, nullable=False)
    input_date = db.Column(db.Date, nullable=False, default=datetime.utcnow)
    due_date = db.Column(db.Date, nullable=False)
