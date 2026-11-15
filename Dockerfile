FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY backend ./backend
EXPOSE 3000
CMD ["gunicorn", "--bind", "0.0.0.0:3000", "--workers", "1", "backend:app"]
