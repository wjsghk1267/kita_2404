import os

# 현재 파일의 절대 경로를 기반으로 basedir 변수를 설정. 이 변수는 프로젝트의 기본 디렉터리를 나타냄.
# os.path.abspath(path): 주어진 경로 path의 절대경로를 반환
# __file__의 디렉토리 부분만을 추출. D:\kdt_240424\workspace\m4_웹애플리케이션구축\TodoList_10
basedir = os.path.abspath(os.path.dirname(__file__))
# Flask configuration
# 세션 데이터 암호화, CSRF 보호 등을 위해 사용

class Config:
    SECRET_KEY = 'f16ab01b47debcaf717a378088a2dcbb155210ae265b0357'
    SQLALCHEMY_DATABASE_URI = "mysql://wjsghk1267:Wjsghk1267!@localhost:3306/wjsghk1267_db"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    UPLOADED_FILES_DEST = os.path.join(basedir, "uploaded")

# os.path.join(basedir, "uploaded")
# os.path.join 함수는 여러 경로 요소를 하나의 경로로 결합
# D:\kdt_240424\workspace\m4_웹애플리케이션구축\TodoList_10\uploads