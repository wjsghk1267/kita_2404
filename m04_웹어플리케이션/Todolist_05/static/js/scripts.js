document.addEventListener("DOMContentLoaded", function () {
    fetch("/tasks")
      .then((response) => response.json())
      .then((tasks) => {
        const taskList = document.getElementById("task-list"); //# id가 task-list인 것에 접근
        tasks.forEach((task) => {
          const li = document.createElement("li");  // html에 대해서 코드 들어감
          li.innerHTML = `<strong>${task.title}</strong><br> 
                          ${task.contents}<br>
                          등록일: ${task.input_date}<br>
                          마감일: ${task.due_date}`;

          const editLink = document.createElement("a");
          editLink.href = `/edit/${task.id}`;
          editLink.textContent = " Edit";
          li.appendChild(editLink);

          const deleteLink = document.createElement("a");
          deleteLink.href = `/delete/${task.id}`;
          deleteLink.textContent = " Delete";
          li.appendChild(deleteLink);

          taskList.appendChild(li);
        });
      });
  });