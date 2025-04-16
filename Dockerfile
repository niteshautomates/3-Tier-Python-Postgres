FROM python:3.11-alpine AS base

WORKDIR /app

COPY requirements.txt ./


RUN python3 -m venv appnv && source appnv/bin/activate

RUN pip3 install --no-cache -r /app/requirements.txt

WORKDIR /app

COPY . .

EXPOSE 5000

CMD [ "python3", "run.py" ]