FROM python:alpine

WORKDIR /app

COPY . ./

RUN pip install . && \
    python setup.py test

ENTRYPOINT [ "challenge_w3" ]
