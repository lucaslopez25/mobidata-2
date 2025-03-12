FROM python:3.13-alpine3.20

WORKDIR /app

# Impede o Python de escrever arquivos .pyc no armazenamento
ENV PYTHONDONTWRITEBYTECODE=1
# Impede o Python de bufferizar o stdout e stderr
ENV PYTHONUNBUFFERED=1 

# Tudo o que está à esquerda está no disco/armaeznamento, e tudo o que está à direita é o que está virtualizado no container
COPY ./requirements.txt /tmp/requirements.txt
COPY ./mobidata2-app /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install --no-cache -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user

EXPOSE 8000

