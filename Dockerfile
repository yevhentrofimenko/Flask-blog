FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y python-pip python-dev build-essential
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
ADD db-dump/testDB.sql /docker-entrypoint-initdb.d/
ENV FLASK_ENV="docker"
EXPOSE 5000
