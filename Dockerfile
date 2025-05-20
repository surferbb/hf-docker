FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/daddylive  # pass to work dir

RUN git pull || git clone https://github.com/pigzillaaaaa/daddylive .

RUN pip install flask curl-cffi m3u8 gunicorn

RUN echo "Rebuild at $(date '+%Y-%m-%d %H:%M:%S')" >> /app/rebuild.log

EXPOSE 7860

CMD ["gunicorn", "--workers", "5", "--worker-class", "gthread", "--threads", "4", "--bind", "0.0.0.0:7860", "proxy:app"]
