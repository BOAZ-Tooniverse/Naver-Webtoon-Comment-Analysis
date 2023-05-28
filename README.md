# Naver-Webtoon-Comment-Analysis
네이버 웹툰 댓글 분석

<br>

## 📌 작업 시 주의사항
<b>

1. 절대 AWS 계정 정보를 Git에 upload하지 않는다.
2. AWS S3 bucket 이름 또한 Git에 upload하지 않는다.
3. 업로드 전 작업한 주피터 노트북의 코드나 출력결과를 다시 한 번 확인하여 credentials 정보가 없는지 확인한다.

</b>



## #️⃣ 로컬 환경 구축 
1. 작업 디렉터리 생성 후 Dockerfile 작성
- 실습할 디렉토리에 가서 Dockerfile을 작성한다. Dockerfile의 내용은 본 Github 파일로 올려둠
- ✅ **이때 20번째 줄에 `S3_BUCKET_NAME`는 실제 AWS S3 버킷 이름으로 변경해준다.** 
2. 도커 이미지 빌드
```
docker build -t advspark .
```
- 이미지 명 advspark로 지정

3. 도커 컨테이너 실행

```shell
docker run -it --name advspark -p 4040:4040 -p 8888:8888 -v E:\docker\Naver-Webtoon-Comment-Analysis\work:/work advspark 
```
- `4040포트`는 spark job을 확인하기 위해 Spark UI 연결함
- `8888포트`는 주피터 노트북이랑 연결되어, 스파크 스크립트를 작성하고 터미널 등에 접근할 수 있도록 함
- `-v` 옵션을 주어 로컬의 디렉토리와 도커의 워킹 디렉토리와 연결해줌
    - 즉, volumn을 mount하여 실제 디스크에 데이터를 영구적으로 저장하여, container가 영구적으로 데이터를 저장할 수도 있도록 함
    - ✅ 자신의 로컬 환경에 맞게 작업 디렉토리 위치를 지정한다. (단 work 디렉토리 이름은 고정하기)
4. 접속  
**http://localhost:8888, http://localhost:4040**
- 접속되는지 확인한다.

5.  실행 중인 컨테이너의 terminal을 키고, spark-defaults.conf 생성
```
cd /spark/conf
cp spark-defaults.conf.template spark-defaults.conf
nano spark-defaults.conf
```
6. 아래 내용을 파일 끝에 입력함
```
spark.hadoop.fs.s3a.impl        org.apache.hadoop.fs.s3a.S3AFileSystem
spark.hadoop.fs.s3a.access.key  <Acess key ID>
spark.hadoop.fs.s3a.secret.key  <Acess key PW>
```
- ✅ 실제 AWS 액세스 키 ID 및 비밀 액세스 키로 대체해서 작성한다.
- 파일을 저장하고 닫으려면 Ctrl + X를 누르고 Y를 누르고 엔터 키를 누른다.

7. 주피터 노트북 실행으로 확인 
- **http://localhost:8888** 접속해서 `test_s3connection.ipynb` 파일을 실행한다.
- 잘 실행된다면 환경 세팅은 성공이다.
- 안 된다면 실행 중인 notebook Shutdown 후 다시 실행해보기

