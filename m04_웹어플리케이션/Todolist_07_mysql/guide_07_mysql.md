
## mysql 설치
pymysql 설치 후 app.py에 다음 사항 추가
import pymysql
pymysql.install_as_MySQLdb()

flask db init
flask db migrate -m "migration"
가상 환경이 활성화된 상태에서 cryptography 패키지(해시 알고리즘 지원, 암호화 작업을 지원하는 Python library)를 설치
flask db upgrade
