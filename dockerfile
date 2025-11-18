FROM python:3.11-slim

# Install ffmpeg + git (for yt-dlp)
RUN apt-get update && apt-get install -y ffmpeg git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=8080
CMD exec gunicorn app:app --bind 0.0.0.0:$PORT --workers 1 --timeout 3600
