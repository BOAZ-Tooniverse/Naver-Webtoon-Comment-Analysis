FROM openjdk:8-jre

# Spark 설치
RUN apt-get update && \
    apt-get install -y curl && \
    curl -O https://downloads.apache.org/spark/spark-3.4.0/spark-3.4.0-bin-hadoop3.tgz  && \
    tar xvf spark-3.4.0-bin-hadoop3.tgz && \
    mv spark-3.4.0-bin-hadoop3 /spark && \
    rm spark-3.4.0-bin-hadoop3.tgz

# aws-java-sdk-bundle 설치
RUN curl -O https://sdk-for-java.amazonwebservices.com/latest/aws-java-sdk-bundle-1.11.874.jar && \
    mv aws-java-sdk-bundle-1.11.874.jar /spark/jars/

RUN apt-get install nano

# 환경 변수 설정
ENV SPARK_HOME=/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV S3_BUCKET_NAME=(bucket_name)

# Jupyter Notebook 설치
RUN apt-get install -y python3-pip && \
    pip3 install jupyter && \
    pip3 install pyspark

# 작업 디렉토리 생성
RUN mkdir /work
WORKDIR /work

# 포트 설정
EXPOSE 8888

# Jupyter Notebook 실행
CMD jupyter notebook --ip 0.0.0.0 --port 8888 --allow-root