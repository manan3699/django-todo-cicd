FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy project files (your HTML, CSS, JS, etc.)
COPY . .

# Expose port
EXPOSE 8000

# Run Python HTTP server on port 8000 (khali py na code ma j use krvu)
CMD ["python3", "-m", "http.server", "8000", "--bind", "0.0.0.0"]
