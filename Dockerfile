FROM python:3.13-alpine AS base

WORKDIR /app

COPY requirements.txt ./app

RUN pip install --no-cache-dir -r app/requirements.txt

FROM --platform=arm64 python:3.13-alpine AS runtime

WORKDIR /app

COPY . ./app/

EXPOSE 5000

CMD [ "python", "./app/run.py" ]