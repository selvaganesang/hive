--! qt:dataset:src
set hive.map.aggr=false;
set hive.groupby.skewindata=false;
set mapred.reduce.tasks=31;

-- SORT_QUERY_RESULTS

CREATE TABLE DEST1(key INT, value STRING) STORED AS TEXTFILE;
CREATE TABLE DEST2(key INT, value STRING) STORED AS TEXTFILE;

SET hive.exec.compress.intermediate=true;
SET hive.exec.compress.output=true; 

EXPLAIN
FROM SRC
INSERT OVERWRITE TABLE DEST1 SELECT SRC.key, sum(SUBSTR(SRC.value,5)) GROUP BY SRC.key ORDER BY SRC.key limit 10
INSERT OVERWRITE TABLE DEST2 SELECT SRC.key, sum(SUBSTR(SRC.value,5)) GROUP BY SRC.key ORDER BY SRC.key limit 10;

FROM SRC
INSERT OVERWRITE TABLE DEST1 SELECT SRC.key, sum(SUBSTR(SRC.value,5)) GROUP BY SRC.key ORDER BY SRC.key limit 10
INSERT OVERWRITE TABLE DEST2 SELECT SRC.key, sum(SUBSTR(SRC.value,5)) GROUP BY SRC.key ORDER BY SRC.key limit 10;

SELECT DEST1.* FROM DEST1;
SELECT DEST2.* FROM DEST2;
