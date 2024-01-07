FROM python:3.7-alpine as base

FROM base AS dependencies

WORKDIR /install

RUN apk add --no-cache gcc musl-dev linux-headers curl mysql-client mysql-dev
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

FROM dependencies

COPY --from=dependencies /install /usr/local

WORKDIR /app
COPY . ./

ENV FLASK_APP=app.py
ENV FLASK_ENV=development
ENV FLASK_RUN_HOST=0.0.0.0
ENV MYSQL_USER=keepcoding
ENV MYSQL_PASSWORD=patodegoma
ENV MYSQL_HOST=mysql-db
ENV MYSQL_DB=mysql-database

EXPOSE 5000

CMD ["flask", "run"]