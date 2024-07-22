document.addEventListener("DOMContentLoaded", function () {
    fetch("/tasks")
      .then((response) => response.json())
      .then((tasks) => {
        const taskList = document.getElementById("task-list");
        tasks.forEach((task) => {
          const li = document.createElement("li");
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