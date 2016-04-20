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

SELECT count(*) FROM tweets;

SELECT count(*) FROM tweets WHERE
  id IS NOT NULL AND
  retweeted_status IS NULL;

SELECT tweets.text FROM tweets WHERE
  id IS NOT NULL AND
  retweeted_status IS NULL
  LIMIT 5;

SELECT split(tweets.text, " ") FROM tweets WHERE
  id IS NOT NULL AND
  retweeted_status IS NULL
  LIMIT 5;

SELECT explode(split(tweets.text, " ")) FROM tweets WHERE
  id IS NOT NULL AND
  retweeted_status IS NULL
  LIMIT 5;

http://www.cnblogs.com/linehrr-freehacker/p/3309088.html
https://cwiki.apache.org/confluence/display/Hive/LanguageManual+LateralView

LATERAL VIEW IS NEEDED HERE?

SELECT pageid, adid
FROM pageAds LATERAL VIEW explode(adid_list) adTable AS adid;


SELECT explode(split(tweets.text, " ")) FROM tweets WHERE
  id IS NOT NULL AND
  retweeted_status IS NULL
  LIMIT 5;


SELECT id, words
FROM tweets LATERAL VIEW explode(split(tweets.text, " ")) myT1 AS words
WHERE retweeted_status IS NULL AND
  words LIKE '%den%' OR
  words LIKE '%denna%' OR
  words LIKE '%denne%' OR
  words LIKE '%det%' OR
  words LIKE '%han%' OR
  words LIKE '%hen%' OR
  words LIKE '%hon%'
LIMIT 20;

OK wee need group by and some LIKE and some LATERAL VIEW

SELECT City, count(*) FROM Customers GROUP BY City;


SELECT word, COUNT(*)
FROM tweets
LATERAL VIEW explode(split(text, ' ')) lTable as word
WHERE retweeted_status IS NULL AND
  word LIKE '%den%' OR
  word LIKE '%denna%' OR
  word LIKE '%denne%' OR
  word LIKE '%det%' OR
  word LIKE '%han%' OR
  word LIKE '%hen%' OR
  word LIKE '%hon%'
GROUP BY word;

####################
SELECT word, COUNT(*)
FROM tweets
LATERAL VIEW explode(
  split(
    regexp_replace(text, "[^a-zA-Z]", " "),
    ' ')
  ) lTable as word
WHERE retweeted_status IS NULL AND
  word LIKE 'den' OR
  word LIKE 'denna' OR
  word LIKE 'denne' OR
  word LIKE 'det' OR
  word LIKE 'han' OR
  word LIKE 'hen' OR
  word LIKE 'hon' 
GROUP BY word;
####################

:!

@*?,."();-+=[]{}|/\\

SELECT * FROM Customers
WHERE City LIKE '[bsp]%';