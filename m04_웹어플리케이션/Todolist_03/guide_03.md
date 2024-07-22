## CSS 스타일
- 브라우저 기본 스타일: 웹 브라우저는 HTML 요소에 기본 스타일을 적용합니다.
- 외부 스타일 시트 (External CSS): <link rel="stylesheet" href="styles.css">와 같은 방식으로 포함된 외부 스타일 시트.
- 내부 스타일 시트 (Internal CSS): HTML 문서의 <head> 태그 내의 <style> 태그로 정의된 스타일.
- 인라인 스타일 (Inline CSS): HTML 요소의 style 속성에 직접 작성된 스타일.

## 우선 순위
styles.css 파일에서 .text { color: green; }를 정의했다고 가정하면:
- 외부 스타일 시트의 color: green은 내부 스타일 시트의 color: blue에 의해 덮어씌워집니다.
- 내부 스타일 시트의 color: blue는 인라인 스타일의 color: red에 의해 덮어씌워집니다.
- 따라서 최종적으로 문서에서 <p> 요소의 텍스트 색상은 빨간색(color: red)이 됩니다.

```
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="styles.css"> <!-- 외부 스타일 시트 -->
    <style> <!-- 내부 스타일 시트 -->
        .text {
            color: blue; /* 이 스타일이 외부 스타일보다 우선 */
        }
    </style>
</head>
<body>
    <p class="text" style="color: red;">Hello, World!</p> <!-- 인라인 스타일 -->
</body>
</html>
```

## index.html css style 적용

전체 스타일

- font-family: Arial, sans-serif;: 본문 텍스트에 Arial 폰트를 적용하고, Arial이 없는 경우 기본 sans-serif 폰트를 사용합니다.
- margin: 20px;: 본문 전체에 20픽셀의 여백을 줍니다.
- background-color: #f4f4f4;: 배경색을 연한 회색으로 설정합니다.

제목 스타일

- color: #333;: 제목 텍스트의 색상을 짙은 회색(#333)으로 설정합니다.

폼 스타일

- margin-bottom: 20px;: 폼의 아래쪽에 20픽셀의 여백을 줍니다.
- background: #fff;: 폼의 배경색을 흰색으로 설정합니다.
- padding: 20px;: 폼 내부에 20픽셀의 여백을 줍니다.
- border-radius: 5px;: 폼의 모서리를 5픽셀 둥글게 만듭니다.
- box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);: 폼에 10픽셀의 흐린 그림자를 추가하여 입체감을 줍니다.

라벨 스타일

- font-weight: bold;: 라벨 텍스트를 굵게 설정합니다.

입력 필드 및 텍스트 영역 스타일

- width: 100%;: 입력 필드와 텍스트 영역의 너비를 부모 요소의 100%로 설정합니다.
- padding: 8px;: 입력 필드와 텍스트 영역 내부에 8픽셀의 여백을 줍니다.
- margin: 10px 0;: 입력 필드와 텍스트 영역 위아래에 10픽셀의 여백을 줍니다.
- border: 1px solid #ccc;: 입력 필드와 텍스트 영역의 테두리를 연한 회색(#ccc) 1픽셀 실선으로 설정합니다.
- border-radius: 4px;: 입력 필드와 텍스트 영역의 모서리를 4픽셀 둥글게 만듭니다.

제출 버튼 스타일

- ackground-color: #4caf50;: 제출 버튼의 배경색을 녹색(#4caf50)으로 설정합니다.
- color: white;: 제출 버튼 텍스트의 색상을 흰색으로 설정합니다.
- padding: 10px 15px;: 제출 버튼 내부에 10픽셀 위아래, 15픽셀 좌우 여백을 줍니다.
- border: none;: 제출 버튼의 테두리를 없앱니다.
- border-radius: 4px;: 제출 버튼의 모서리를 4픽셀 둥글게 만듭니다.
- cursor: pointer;: 마우스 포인터를 손가락 모양으로 변경하여 클릭 가능한 요소임을 나타냅니다.
- input[type="submit"]:hover: 제출 버튼에 마우스를 올렸을 때 배경색을 약간 어두운 녹색(#45a049)으로 변경합니다.

목록 스타일

- list-style-type: none;: 목록 항목의 기본 불릿 스타일을 없앱니다.
- padding: 0;: 목록의 내부 여백을 없앱니다.

목록 항목 스타일

- background: #fff;: 목록 항목의 배경색을 흰색으로 설정합니다.
- margin: 10px 0;: 목록 항목의 위아래에 10픽셀의 여백을 줍니다.
- padding: 15px;: 목록 항목 내부에 15픽셀의 여백을 줍니다.
- border-radius: 5px;: 목록 항목의 모서리를 5픽셀 둥글게 만듭니다.
- box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);: 목록 항목에 10픽셀의 흐린 그림자를 추가하여 입체감을 줍니다.

링크 스타일

- margin-left: 10px;: 링크의 왼쪽에 10픽셀의 여백을 줍니다.
- color: #007bff;: 링크 텍스트의 색상을 파란색(#007bff)으로 설정합니다.
- text-decoration: none;: 링크의 밑줄을 없앱니다.
- a:hover: 링크에 마우스를 올렸을 때 밑줄을 추가하여 강조합니다.

## edit_task.html css style

전체 스타일

- font-family: Arial, sans-serif;: 본문 텍스트에 Arial 폰트를 적용하고, Arial이 없는 경우 기본 sans-serif 폰트를 사용합니다.
- margin: 20px;: 본문 전체에 20픽셀의 여백을 줍니다.
- background-color: #f4f4f4;: 배경색을 연한 회색으로 설정합니다.

제목 스타일

- color: #333;: 제목 텍스트의 색상을 짙은 회색(#333)으로 설정합니다.
  폼 스타일
- margin-bottom: 20px;: 폼의 아래쪽에 20픽셀의 여백을 줍니다.
- background: #fff;: 폼의 배경색을 흰색으로 설정합니다.
- padding: 20px;: 폼 내부에 20픽셀의 여백을 줍니다.
- border-radius: 5px;: 폼의 모서리를 5픽셀 둥글게 만듭니다.
- box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);: 폼에 10픽셀의 흐린 그림자를 추가하여 입체감을 줍니다.

라벨 스타일

- font-weight: bold;: 라벨 텍스트를 굵게 설정합니다.
  입력 필드 및 텍스트 영역 스타일
- width: 100%;: 입력 필드와 텍스트 영역의 너비를 부모 요소의 100%로 설정합니다.
- padding: 8px;: 입력 필드와 텍스트 영역 내부에 8픽셀의 여백을 줍니다.
- margin: 10px 0;: 입력 필드와 텍스트 영역 위아래에 10픽셀의 여백을 줍니다.
- border: 1px solid #ccc;: 입력 필드와 텍스트 영역의 테두리를 연한 회색(#ccc) 1픽셀 실선으로 설정합니다.
- border-radius: 4px;: 입력 필드와 텍스트 영역의 모서리를 4픽셀 둥글게 만듭니다.

제출 버튼 스타일

- background-color: #4caf50;: 제출 버튼의 배경색을 녹색(#4caf50)으로 설정합니다.
- color: white;: 제출 버튼 텍스트의 색상을 흰색으로 설정합니다.
- padding: 10px 15px;: 제출 버튼 내부에 10픽셀 위아래, 15픽셀 좌우 여백을 줍니다.
- border: none;: 제출 버튼의 테두리를 없앱니다.
- border-radius: 4px;: 제출 버튼의 모서리를 4픽셀 둥글게 만듭니다.
- cursor: pointer;: 마우스 포인터를 손가락 모양으로 변경하여 클릭 가능한 요소임을 나타냅니다.
- input[type="submit"]:hover: 제출 버튼에 마우스를 올렸을 때 배경색을 약간 어두운 녹색(#45a049)으로 변경합니다.

링크 스타일

- color: #007bff;: 링크 텍스트의 색상을 파란색(#007bff)으로 설정합니다.
- text-decoration: none;: 링크의 밑줄을 없앱니다.
- a:hover: 링크에 마우스를 올렸을 때 밑줄을 추가하여 강조합니다
