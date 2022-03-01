#Docker image for flask python run
FROM python:3.8
COPY requirements.txt /project/
WORKDIR /project/
RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
ENTRYPOINT ["python","app.py"]
