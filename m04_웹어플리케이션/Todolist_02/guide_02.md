## TodoList_01 대비 추가한 내용

필드 수

- 기존 코드에서는 Task 모델에 id 와 title 필드만 있음.
- 수정된 코드에서는 title, contents, input_date, due_date 필드가 추가되어 있음.

한국 시간으로 등록일 설정

- 수정된 코드에서는 pytz를 사용하여 input_date를 한국 시간으로 설정함.

CSRF 보호

- 기존 방식은 FlaskForm 객체를 통해 CSRF 토큰을 관리하며, 수정된 방식은 CSRF 토큰을 별도로 템플릿에 전달합니다.
- 두 방식 모두 CSRF 보호를 제공하지만, 수정된 방식은 폼 객체를 사용하지 않는 경우에도 CSRF 토큰을 쉽게 추가할 수 있는 유연성을 제공합니다.

템플릿 수정

- index.html과 edit_task.html 템플릿에 CSRF 토큰을 추가함.
- 작업 목록을 JavaScript로 더 상세히 표시하도록 수정됨.

폼 렌더링과 폼 제출을 각각 다른 라우트에서 처리

- 수정된 코드에서 GET 요청만 처리하도록 변경된 이유는, 폼 제출을 별도의 라우트에서 처리하도록 분리하기 위함일 수 있습니다.
- 이는 코드의 가독성을 높이고, 각 라우트가 하나의 역할만 담당하게 하여 유지보수를 쉽게 하기 위한 방법입니다.


데이터베이스 마이그레이션 - Flask-Migrate를 사용하여 새로운 컬럼을 추가하는 방법
- Flask-Migrate 설치: pip install Flask-Migrate
- Flask-Migrate 초기 설정: Flask-Migrate를 초기화하려면 애플리케이션 파일을 업데이트하여 Migrate 객체를 생성
    ```
    from flask_migrate import Migrate

    app = Flask(__name__)
    app.config['SECRET_KEY'] = ''
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///example.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db = SQLAlchemy(app)
    migrate = Migrate(app, db)
    ```
- 마이그레이션 초기화: flask db init
- 모델 변경 시 마이그레이션
    - 마이그레이션 생성: flask db migrate -m "Add columns to Task"
    - 마이그레이션 적용: flask db upgrade


    세션 관리
- 세션은 웹 애플리케이션에서 클라이언트와 서버 간의 상호작용 상태를 유지하기 위한 방법. (클라이언트<->서버 간 활동은 독립 이벤트로 log가 저장되거나 연계되지 않음, 이를 보안한 방법 (cookie))
- Flask는 기본적으로 클라이언트 측 세션을 쿠키를 통해 관리합니다. 이를 위해 Flask는 SECRET_KEY를 사용하여 세션 데이터를 암호화하고 서명
- 동작 방식
    - 사용자가 웹 애플리케이션과 상호작용하면, 서버는 세션 데이터를 설정. 예를 들어, 사용자가 로그인하면 서버는 사용자의 이름이나 아이디와 같은 정보를 세션에 저장
    - Flask는 세션 데이터를 JSON 형식으로 직렬화한 후, 서버의 SECRET_KEY를 사용하여 이 데이터를 암호화하고 서명. 이를 통해 클라이언트가 세션 데이터를 임의로 수정할 수 없도록 보호
    - 암호화되고 서명된 세션 데이터는 클라이언트의 브라우저 쿠키에 저장
    - 사용자가 웹 애플리케이션에 요청을 보낼 때마다, 클라이언트의 브라우저는 세션 쿠키를 서버로 전송. 서버는 쿠키에 저장된 암호화된 세션 데이터를 복호화하고 서명을 검증하여 세션의 무결성과 기밀성을 확인
    - CSRF 보호를 위해, SECRET_KEY를 사용하여 고유한 CSRF 토큰을 생성합니다. 이 토큰은 폼과 함께 전송되어, 서버가 이를 검증함으로써 CSRF 공격을 방지
