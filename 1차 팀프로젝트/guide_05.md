## Jinja2는 파이썬 기반의 템플릿 엔진

1. 주석
  {# 주석 내용 #}

2. 변수
  {{ 변수명 }}

3. 제어 구조
  - 조건에 따라 다른 내용을 렌더링합니다.
  {% if 조건 %}
    <p>조건이 참일 때 실행되는 내용</p>
  {% elif 다른_조건 %}
    <p>다른 조건이 참일 때 실행되는 내용</p>
  {% else %}
    <p>모든 조건이 거짓일 때 실행되는 내용</p>
  {% endif %}

  - 시퀀스의 각 항목에 대해 블록의 내용을 반복
  <ul>
  {% for item in items %}
    <li>{{ item }}</li>
  {% endfor %}
  </ul>

4. 블록과 확장
  - 템플릿에서 재정의할 수 있는 블록을 정의
  {% block 블록이름 %}
  블록 내용
  {% endblock %}
  - 공통 레이아웃을 정의한 기본 템플릿을 확장
  {% extends "base.html" %}

5. 필터
  - 변수를 출력할 때 필터를 적용하여 값을 변환
  {{ 변수명|필터 }}


## base.html을 이용한 효율적 템플릿 관리 - 중복 코드 최소화

1. extends
  {% extends "base.html" %}
  설명: 특정 템플릿 파일이 다른 기본 템플릿 파일을 확장하도록 합니다. 여기서는 base.html을 확장하고 있습니다.
  사용 이유: 공통 요소를 기본 템플릿으로 정의하여 중복 코드를 줄이고 유지보수성을 높입니다.

2. block
  {% block title %}{% endblock %}
  설명: block 태그는 템플릿에서 재정의할 수 있는 블록을 정의합니다. block과 endblock 사이의 콘텐츠는 개별 템플릿 파일에서 재정의될 수 있습니다.
  사용 이유: 기본 템플릿에서 특정 부분을 동적으로 변경할 수 있도록 합니다. 예를 들어, 페이지마다 다른 제목을 설정할 수 있습니다.

3. super
  {{ super() }}
  설명: super 함수는 부모 블록의 콘텐츠를 포함하도록 합니다.
  사용 이유: 기본 템플릿의 블록 콘텐츠를 포함하면서 추가적인 콘텐츠를 덧붙일 때 유용합니다.

4. 주요 포인트
  - 공통 요소 정의: base.html에서 공통으로 사용할 HTML 구조와 스타일을 정의합니다.
  - 확장: 개별 페이지 템플릿에서 {% extends "base.html" %}를 사용하여 base.html을 확장합니다.
  -블록 재정의: 각 페이지 템플릿에서 {% block ... %}{% endblock %} 태그를 사용하여 base.html에서 정의한 블록을 재정의합니다.


  base.html :
  ```
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <title>{% block title %}{% endblock %}</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='css/style.css') }}">
    <script src="{{ url_for('static', filename='js/scripts.js') }}" defer></script>
  </head>
  <body>
    <h1>{% block header %}{% endblock %}</h1>
    <div class="content">
      {% block content %}{% endblock %}
    </div>
  </body>
  </html>  
  ```

  index.html :
  ```
  {% extends "base.html" %}
  {% block title %}Task List{% endblock %}
  {% block header %}Task List{% endblock %}
  {% block content %}
    <form method="POST" action="/">
      {{ form.csrf_token }}
      <p>
        <label for="title">제목</label><br />
        {{ form.title(size=32) }}
      </p>
      <p>
        <label for="contents">내용</label><br />
        {{ form.contents(rows=4) }}
      </p>
      <p>
        <label for="due_date">마감일</label><br />
        {{ form.due_date() }}
      </p>
      <p><input type="submit" value="Add Task"></p>
    </form>
    <ul id="task-list">
      <!-- Task items will be populated here by JavaScript -->
    </ul>
  {% endblock %}  
  ```



 TodoList_05/
│
├── app.py
├── config.py
├── form.py
├── models.py
├── static/
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── scripts.js
│  
├── templates/
│   ├── base.html
│   ├── index.html
│   └── edit_task.html
└── myenv/ 


각 파일의 기능

app.py:
  플라스크 애플리케이션을 초기화하고 라우트를 정의합니다.
  주요 라우트:
  GET /: 메인 페이지를 렌더링합니다.
  GET /tasks: 모든 작업을 JSON 형식으로 반환합니다.
  POST /: 작업 추가 폼을 처리하고 새로운 작업을 데이터베이스에 저장합니다.
  GET /edit/int:task_id: 특정 작업의 수정 페이지를 표시합니다.
  POST /edit/int:task_id: 작업 수정 폼을 처리하고 데이터를 업데이트합니다.
  GET /delete/int:task_id: 특정 작업을 삭제합니다.
  config.py: 데이터베이스 설정 및 기타 애플리케이션 설정을 포함합니다.

form.py:
  플라스크 WTF 폼을 정의합니다.
  작업 추가 및 수정 시 사용되는 폼 필드와 유효성 검사를 정의합니다.

models.py:
  데이터베이스 모델을 정의합니다.
  작업(Task) 모델을 포함하며, 작업의 필드와 속성을 정의합니다.

static/:
  css/: 애플리케이션의 스타일시트를 포함하는 디렉토리
    style.css: 애플리케이션의 전반적인 스타일을 정의합니다.
  js/: 애플리케이션의 자바스크립트를 포함하는 디렉토리
    scripts.js: 작업 목록을 동적으로 표시하기 위한 자바스크립트 코드를 포함합니다.

templates/:
  base.html: 모든 페이지가 공통적으로 사용하는 기본 템플릿입니다. 다른 템플릿이 이 파일을 확장하여 사용합니다.
  index.html: 메인 페이지 템플릿으로 작업 추가 폼과 작업 목록을 포함합니다.
  edit_task.html: 작업 수정 페이지 템플릿으로 기존 작업의 세부 정보를 편집할 수 있습니다.
