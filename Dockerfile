FROM python:3.10-slim

# Linux path inside container
WORKDIR /app

COPY . .

EXPOSE 8000

# CMD to run Django app or HTML server
CMD ["python", "-m", "http.server", "8000"]
