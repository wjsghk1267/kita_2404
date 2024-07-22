import sqlite3

# SQLite 데이터베이스 파일 경로
db_path = 'instance/tasks.db'

# 데이터베이스 연결
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# alembic_version 테이블의 모든 내용 삭제
cursor.execute("DELETE FROM alembic_version")

# 변경사항 커밋
conn.commit()

# 연결 닫기
conn.close()
