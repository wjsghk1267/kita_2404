## 주요 변경 사항
- 글꼴 변경: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif를 사용하여 좀 더 현대적인 느낌을 줍니다.
- 배경색 변경: body의 배경색을 #e0f7fa로 변경하여 더 밝고 경쾌한 분위기를 조성합니다.
- 중앙 정렬: form과 ul 요소를 중앙에 정렬하여 가독성을 높입니다.
- 박스 그림자 강화: form과 li 요소의 그림자 효과를 강화하여 입체감을 더합니다.
- 색상과 스타일 조정: 버튼과 링크의 색상과 스타일을 조정하여 더 세련된 느낌을 줍니다.
- 전환 효과 추가: 버튼과 링크에 전환 효과를 추가하여 사용자 경험을 향상시킵니다.

## 주요 변경 사항
- 글꼴 변경: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif를 사용하여 좀 더 현대적인 느낌을 줍니다.
- 배경색 변경: body의 배경색을 #e0f7fa로 변경하여 더 밝고 경쾌한 분위기를 조성합니다.
- 중앙 정렬: form과 ul 요소를 중앙에 정렬하여 가독성을 높입니다.
- 박스 그림자 강화: form과 li 요소의 그림자 효과를 강화하여 입체감을 더합니다.
- 색상과 스타일 조정: 버튼과 링크의 색상과 스타일을 조정하여 더 세련된 느낌을 줍니다.
- 전환 효과 추가: 버튼과 링크에 전환 효과를 추가하여 사용자 경험을 향상시킵니다.

body:
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;: 페이지 전체의 글꼴을 현대적인 'Segoe UI'와 같은 산세리프 글꼴로 설정합니다.
margin: 0;: 문서의 기본 여백을 제거합니다.
padding: 20px;: 문서의 안쪽 여백을 20픽셀로 설정합니다.
background-color: #e0f7fa;: 배경색을 밝은 청록색(#e0f7fa)으로 설정합니다.

h1:
color: #00796b;: 제목 텍스트의 색상을 어두운 청록색(#00796b)으로 설정합니다.
text-align: center;: 제목을 가운데 정렬합니다.

form:
margin-bottom: 20px;: 폼 하단에 20픽셀의 여백을 추가합니다.
background: #ffffff;: 폼의 배경색을 흰색으로 설정합니다.
padding: 20px;: 폼 내부 여백을 20픽셀로 설정합니다.
border-radius: 10px;: 모서리를 10픽셀 반경으로 둥글게 설정합니다.
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);: 폼에 약간의 그림자를 추가하여 입체감을 줍니다.
max-width: 600px;: 폼의 최대 너비를 600픽셀로 제한합니다.
margin-left: auto; margin-right: auto;: 폼을 가운데 정렬합니다.

label:
font-weight: bold;: 레이블 텍스트를 굵게 설정합니다.
color: #00796b;: 레이블 텍스트의 색상을 어두운 청록색으로 설정합니다.

input[type="text"], input[type="date"], textarea:
width: calc(100% - 16px);: 입력 필드와 텍스트 영역의 너비를 부모 요소의 너비에서 16픽셀 뺀 값으로 설정합니다.
padding: 8px;: 내부 여백을 8픽셀로 설정합니다.
margin: 10px 0;: 상하 여백을 10픽셀로 설정합니다.
border: 1px solid #b0bec5;: 회색(#b0bec5) 테두리를 설정합니다.
border-radius: 4px;: 모서리를 4픽셀 반경으로 둥글게 설정합니다.
box-sizing: border-box;: padding과 border 값을 내부에 포함하도록 설정합니다.(기본값 content-box는 패딩과 보더가 콘텐츠 너비에 추가)

input[type="submit"]:
background-color: #00796b;: 제출 버튼의 배경색을 어두운 청록색으로 설정합니다.
color: white;: 버튼 텍스트 색상을 흰색으로 설정합니다.
padding: 10px 20px;: 상하 10픽셀, 좌우 20픽셀의 여백을 설정합니다.
border: none;: 버튼의 테두리를 제거합니다.
border-radius: 4px;: 모서리를 4픽셀 반경으로 둥글게 설정합니다.
cursor: pointer;: 마우스를 올렸을 때 커서가 포인터로 변경됩니다.
transition: background-color 0.3s;: 배경색이 변화할 때 0.3초 동안 부드럽게 전환되도록 설정합니다.

input[type="submit"]:hover:
background-color: #004d40;: 마우스를 올렸을 때 버튼의 배경색을 더 어두운 색(#004d40)으로 변경합니다.

a:
color: #00796b;: 링크 텍스트의 색상을 어두운 청록색으로 설정합니다.
text-decoration: none;: 링크의 밑줄을 제거합니다.
transition: color 0.3s;: 색상이 변화할 때 0.3초 동안 부드럽게 전환되도록 설정합니다.

a:hover:
color: #004d40;: 마우스를 올렸을 때 링크의 색상을 더 어두운 색으로 변경합니다.
text-decoration: underline;: 마우스를 올렸을 때 링크에 밑줄을 추가합니다.

p:
max-width: 600px;: 단락의 최대 너비를 600픽셀로 제한합니다.
margin-left: auto; margin-right: auto;: 단락을 가운데 정렬합니다.
color: #00796b;: 단락 텍스트의 색상을 어두운 청록색으로 설정합니다.