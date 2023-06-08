FROM python:3.11.3-bullseye

COPY /src /src
COPY Trade.avsc .
COPY requirements.txt .

ENV FINNHUB_API_KEY=chup7ppr01qphnn2crmgchup7ppr01qphnn2crn0

RUN pip install -r requirements.txt
CMD ["python", "-u", "src/main.py"]

