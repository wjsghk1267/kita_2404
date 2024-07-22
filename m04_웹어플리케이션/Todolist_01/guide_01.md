# 디렉토리 구조

TodoList_01/
│
├── app.py
├── config.py
├── templates/
│ ├── index.html
│ └── edit_task.html
└── webenv

## Flask 애플리케이션 (app.py)

- Flask: 웹 애플리케이션을 생성하는 핵심 프레임워크.
- render_template: HTML 템플릿을 렌더링합니다.
- redirect, url_for: 사용자를 리디렉션하고 URL을 생성합니다.
- request: 들어오는 요청 데이터를 처리합니다.
- jsonify: 파이썬 객체를 JSON 응답으로 변환합니다.
- SQLAlchemy: 데이터베이스 작업을 위한 ORM (객체 관계 매핑) 라이브러리.
- FlaskForm: WTForms와 Flask를 통합하는 기본 클래스.
- StringField, SubmitField: WTForms의 폼 필드.
- DataRequired: 필드가 비어 있지 않도록 하는 검증기.

애플리케이션 및 데이터베이스 설정

- app = Flask(name): Flask 애플리케이션 인스턴스를 생성합니다.
- app.config.from_pyfile("config.py"): config.py 파일에서 설정을 로드합니다.
- db = SQLAlchemy(app): SQLAlchemy를 애플리케이션과 연결하여 데이터베이스 작업을 처리합니다.

Task 모델

- Task: 데이터베이스의 테이블을 나타내는 모델 클래스입니다.
- id: 각 태스크를 고유하게 식별하는 정수형 기본 키.
- title: 태스크 제목을 저장하는 문자열 필드, null이 될 수 없습니다.

Task 폼

- TaskForm: 태스크를 추가/편집하기 위한 폼 클래스입니다.
- title: 태스크 제목을 입력받는 텍스트 필드, 필수 입력 필드.
- submit: 태스크를 추가하는 제출 버튼.

인덱스 라우트

- @app.route("/", methods=["GET", "POST"]): GET 및 POST 요청을 처리하는 루트 경로를 정의합니다.
- form = TaskForm(): TaskForm의 인스턴스를 생성합니다.
- if form.validate_on_submit(): 폼이 제출되고 유효한지 확인합니다.
- new_task = Task(title=form.title.data): 새로운 Task 객체를 생성합니다.
- db.session.add(new_task), db.session.commit(): 새로운 태스크를 데이터베이스에 추가하고 커밋합니다.
- return redirect(url_for("index")): 태스크를 추가한 후 인덱스 페이지로 리디렉션합니다.
- return render_template("index.html", form=form): index.html 템플릿을 폼과 함께 렌더링합니다.

태스크 라우트

- 데이터베이스 쿼리: GET 요청이 /tasks로 들어오면, 함수는 Task.query.all()을 실행하여 데이터베이스에서 모든 작업 레코드를 가져옵니다.
- 데이터 형식화: 가져온 작업 레코드는 각 작업의 id와 title을 포함하는 딕셔너리 목록으로 형식화됩니다.
- JSON 응답: 작업 딕셔너리 목록은 jsonify 함수에 전달되어 JSON 응답으로 변환된 후 클라이언트에 반환됩니다.
- /tasks 라우트를 구현함으로써, 애플리케이션은 클라이언트 측 코드가 현재 작업 목록을 가져오고 표시할 수 있는 기능을 제공하여, 페이지 전체를 새로 고치지 않고도 작업 목록을 동적으로 업데이트할 수 있습니다.

에딧 라우트

- @app.route("/edit/int:task_id", methods=["GET", "POST"]): 태스크 ID로 태스크를 편집하는 라우트를 정의합니다.
- task = Task.query.get_or_404(task_id): 태스크를 조회하거나, 없으면 404 오류를 반환합니다.
- if form.validate_on_submit(): 폼이 제출되고 유효한지 확인합니다.
- task.title = form.title.data: 태스크 제목을 업데이트합니다.
- db.session.commit(): 변경 사항을 데이터베이스에 커밋합니다.
- return redirect(url_for("index")): 인덱스 페이지로 리디렉션합니다.
- form.title.data = task.title: 현재 태스크 제목으로 폼을 미리 채웁니다.
- return render_template("edit_task.html", form=form, task_id=task.id, task_title=task.title): edit_task.html 템플릿을 폼, 태스크 ID, 태스크 제목과 함께 렌더링합니다.

딜릿 라우트

- @app.route("/delete/int:task_id"): 태스크를 삭제하는 라우트를 정의합니다.
- task = Task.query.get_or_404(task_id): 태스크를 조회하거나, 없으면 404 오류를 반환합니다.
- db.session.delete(task), db.session.commit(): 태스크를 삭제하고 데이터베이스에 커밋합니다.
- return redirect(url_for("index")): 인덱스 페이지로 리디렉션합니다.

애플리케이션 진입

- if name == "main": 스크립트가 직접 실행될 때만 코드를 실행합니다.
- with app.app_context(): db.create_all(): 애플리케이션 컨텍스트 내에서 데이터베이스 테이블을 생성합니다.
- app.run(debug=True): Flask 애플리케이션을 디버그 모드로 실행합니다.

## index.html

DOMContentLoaded 이벤트 리스너 등록:

- /tasks 라우트는 app.py 파일에서 정의된 엔드포인트로, 데이터베이스에서 모든 작업(task) 목록을 가져와 JSON 형식으로 반환하는 역할을 합니다. 이 라우트는 GET 방식으로 접근할 수 있습니다.
- document.addEventListener("DOMContentLoaded", function () { ... });는 문서의 DOM 콘텐츠가 완전히 로드된 후에만 코드를 실행하도록 합니다. 이 이벤트는 HTML 문서가 완전히 로드되고 파싱되었을 때 발생합니다. 이를 통해 전체 페이지가 로드된 후에만 작업을 수행할 수 있습니다.
- fetch API를 사용한 데이터 가져오기:
  fetch("/tasks")는 서버의 /tasks 엔드포인트로 HTTP GET 요청을 보냅니다. 이 엔드포인트는 태스크 목록을 JSON 형식으로 반환합니다.
- 응답 처리 및 JSON 변환:
  .then((response) => response.json())는 서버의 응답을 JSON 형식으로 변환합니다. response.json()은 프로미스를 반환하며, 이 프로미스(Promise)가 해결되면 실제 JSON 데이터를 사용할 수 있습니다.
- 태스크 목록 처리:
  .then((tasks) => { ... })는 JSON 데이터를 받아서 이를 처리하는 콜백 함수를 정의합니다. tasks는 태스크 객체들의 배열입니다.
- DOM 조작:
  const taskList = document.getElementById("task-list");는 HTML 문서에서 id가 task-list인 요소를 찾습니다. 이 요소는 태스크 항목을 추가할 리스트입니다.
  tasks.forEach((task) => { ... })는 각 태스크 객체에 대해 콜백 함수를 실행합니다.

HTML 코드 구조

- <form method="POST" action="/">
  사용자가 태스크를 추가할 수 있는 입력 폼을 정의합니다.
  method="POST": 폼 데이터를 서버로 보낼 때 POST 방식을 사용합니다. 이는 일반적으로 데이터를 서버에 제출할 때 사용됩니다.
  action="/": 폼 데이터가 제출될 URL을 지정합니다. 이 경우 루트 URL(홈페이지)로 폼 데이터가 제출됩니다.
- <input type="hidden" name="csrf_token" value="{{ form.csrf_token._value() }}" />
  CSRF 공격은 사용자가 신뢰하는 웹사이트를 대상으로 사용자의 권한을 도용하여 악의적인 요청을 보내는 공격입니다. 예를 들어, 사용자가 로그인한 상태에서 악성 웹사이트를 방문하면 해당 웹사이트는 사용자의 권한을 이용해 원치 않는 요청을 보낼 수 있습니다.
  CSRF 토큰은 서버가 생성한 고유한 값으로, 사용자의 요청이 실제로 해당 사용자가 의도한 것인지 확인하는 데 사용됩니다. 서버는 폼을 생성할 때 CSRF 토큰을 포함시키고, 서버는 폼 제출 시 토큰이 유효한지 확인합니다.
  type="hidden": 이 입력 필드는 사용자에게 보이지 않습니다.
  name="csrf_token": 서버가 CSRF 토큰을 식별할 수 있도록 이름을 설정합니다.
  value="{{ form.csrf_token._value() }}": Flask-WTF 폼에서 생성된 CSRF 토큰 값을 설정합니다. 이 부분은 Jinja2 템플릿 문법으로, 서버에서 렌더링될 때 실제 값으로 대체됩니다.
  - 작동 방식:
    서버 측: 서버는 폼을 생성할 때 사용자 세션에 CSRF 토큰을 생성하고 저장합니다. 이 토큰은 해당 사용자의 요청에 포함되어야 합니다.
    클라이언트 측: 사용자가 폼을 제출하면, 숨겨진 입력 필드에 포함된 CSRF 토큰도 함께 제출됩니다.
    서버 측 검증: 서버는 제출된 CSRF 토큰이 세션에 저장된 토큰과 일치하는지 확인합니다. 일치하면 요청이 유효한 것으로 간주하고, 그렇지 않으면 요청을 거부합니다.
- <p>
  HTML 문단 요소입니다. 여기에 폼 필드와 레이블이 포함됩니다.
- <input type="text" name="title" id="title" size="32" required />
  사용자로부터 텍스트 입력을 받는 필드를 정의합니다.
  type="text": 텍스트 입력 필드입니다.
  name="title": 폼이 제출될 때 서버에서 이 입력 필드를 식별할 수 있는 이름을 설정합니다.
  id="title": 레이블과 연결된 고유 식별자를 설정합니다.
  size="32": 입력 필드의 너비를 설정합니다.
  required: 이 필드가 비어 있으면 폼을 제출할 수 없도록 합니다. 사용자가 필수로 입력해야 함을 나타냅니다.
- <p><input type="submit" value="Add Task" /></p>
  폼 제출 버튼을 정의합니다.
  type="submit": 버튼을 클릭하면 폼이 제출됩니다.
  value="Add Task": 버튼에 표시될 텍스트를 설정합니다. 사용자가 이 버튼을 클릭하면 태스크가 추가됩니다.
- <ul id="task-list">
  태스크 목록을 표시할 비정렬 목록 요소를 정의합니다.
  id="task-list": 자바스크립트 코드에서 이 요소를 식별하고 조작할 수 있도록 고유 식별자를 설정합니다. 태스크 항목이 여기에 동적으로 추가됩니다.

## edit_task.html

- <form method="POST" action="/edit/{{ task_id }}">
  사용자가 태스크를 편집할 수 있는 입력 폼을 정의합니다.
  method="POST": 폼 데이터를 서버로 보낼 때 POST 방식을 사용합니다. 이는 일반적으로 데이터를 서버에 제출할 때 사용됩니다.
  action="/edit/{{ task_id }}": 폼 데이터가 제출될 URL을 지정합니다. 여기서 {{ task_id }}는 Jinja2 템플릿 문법으로, 서버에서 렌더링될 때 실제 태스크 ID로 대체됩니다. 이 URL로 폼 데이터가 제출됩니다.
- <input type="hidden" name="csrf_token" value="{{ form.csrf_token._value() }}" />
  CSRF(Cross-Site Request Forgery) 공격을 방지하기 위해 사용됩니다.
  type="hidden": 이 입력 필드는 사용자에게 보이지 않습니다.
  name="csrf_token": 서버가 CSRF 토큰을 식별할 수 있도록 이름을 설정합니다.
  value="{{ form.csrf_token._value() }}": Flask-WTF 폼에서 생성된 CSRF 토큰 값을 설정합니다. 이 부분은 Jinja2 템플릿 문법으로, 서버에서 렌더링될 때 실제 값으로 대체됩니다.
- <p>
  HTML 문단 요소입니다. 여기에 폼 필드와 레이블이 포함됩니다.
- <label for="title">Title</label><br />
- <br />: 줄 바꿈을 삽입하여 다음 요소를 새로운 줄에 표시합니다.
- <input type="text" name="title" id="title" size="32" value="{{ task_title }}" required />
  사용자로부터 텍스트 입력을 받는 필드를 정의합니다.
  type="text": 텍스트 입력 필드입니다.
  name="title": 폼이 제출될 때 서버에서 이 입력 필드를 식별할 수 있는 이름을 설정합니다.
  id="title": 레이블과 연결된 고유 식별자를 설정합니다.
  size="32": 입력 필드의 너비를 설정합니다.
  value="{{ task_title }}": 현재 태스크 제목을 미리 채워 넣습니다. 이 부분은 Jinja2 템플릿 문법으로, 서버에서 렌더링될 때 실제 태스크 제목으로 대체됩니다.
  required: 이 필드가 비어 있으면 폼을 제출할 수 없도록 합니다. 사용자가 필수로 입력해야 함을 나타냅니다.
- <p><input type="submit" value="Edit Task" /></p>
  폼 제출 버튼을 정의합니다.
  type="submit": 버튼을 클릭하면 폼이 제출됩니다.
  value="Edit Task": 버튼에 표시될 텍스트를 설정합니다. 사용자가 이 버튼을 클릭하면 태스크 편집이 완료됩니다.
- <a href="/">Back to Task List</a>
  사용자가 태스크 목록 페이지로 돌아갈 수 있는 링크를 제공합니다.
  href="/": 루트 URL(홈페이지)로 이동하는 링크를 설정합니다.
