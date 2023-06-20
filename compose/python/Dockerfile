FROM python:3.11.3-bullseye

COPY /src /src
COPY Trade.avsc .
COPY requirements.txt .

RUN pip install -r requirements.txt
CMD ["python", "-u", "src/main.py"]

