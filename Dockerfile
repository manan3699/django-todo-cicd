FROM python:3.10-slim

WORKDIR /app

RUN pip install flask

COPY . .

EXPOSE 8000

CMD ["python", "ChatBot for ci-cd", "app.py"]
