DROP TABLE IF EXISTS tweets;

ADD JAR
/home/ubuntu/Hive-JSON-Serde/json-serde/target/json-udf-1.3.7-jar-with-dependencies.jar;

CREATE EXTERNAL TABLE tweets
(
  id STRING,
  text STRING,
  retweeted_status STRING
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '/user/ubuntu/titter_db';

LOAD DATA INPATH '/user/ubuntu/test-data/tweets_0.txt' OVERWRITE INTO TABLE tweets;