FROM python:3.10-slim

WORKDIR D:\new\django-todo-cicd\jenkinsfile


COPY . .

EXPOSE 8000

CMD ["HTML", "todo.html"]
