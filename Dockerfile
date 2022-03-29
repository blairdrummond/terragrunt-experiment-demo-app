ARG PYTHON_TAG=3.9-alpine
FROM python:$PYTHON_TAG

COPY app/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

RUN mkdir -p /home/app \
    && chown -R app /home/app

USER 1000

WORKDIR /home/app
COPY app .

CMD ["uvicorn", "app:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
