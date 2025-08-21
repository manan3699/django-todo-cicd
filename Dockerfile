FROM python:3.10-slim

WORKDIR D:\new\dockerfile

COPY . .

EXPOSE 8000

CMD ["HTML", "todo.html"]
