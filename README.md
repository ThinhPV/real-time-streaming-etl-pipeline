# Real-time streaming ETL pipeline

Streaming ETL (Extract, Transform, Load) is the processing and movement of real-time data from one place to another.

In traditional data environments, ETL software extracted batches of data from a source system usually based on a schedule, transformed that data, then loaded it to a repository such as a data warehouse or database. This is the “batch ETL” model. However, many modern business environments cannot wait hours or days for applications to handle batches of data. They must respond to new data in real time as the data is generated.

One example of the use of streaming ETL is real-time stock data.

## ------------------------------------------------------


## Real-time stock data with Apache Kafka, Kafka Connect and ksqlDB

Let's take a look at a real use case to show an end-to-end solution. This one simulates the processing of stock exchange data with Apache Kafka and ksqlDB.

In the example, Kafka Connect extracts stock exchange data into Kafka topics. ksqlDB then picks it up, processes it, and places the processed data into another Kafka topic.

![Real-time streaming ETL pipeline](/docs/images/etl-pipeline.png "ETL pipeline bluesprint")

## Starting up the architecture

In order to run the infrastructure you should build and run the docker-compose file.

Start every container described in the `docker-compose.yml`,

```bash
> docker-compose up -d
```


## Building the ETL Pipeline

First we should create source connector (debezium) for listening the changes in the frankfurt_stock_data_table. First things first we should open up a terminal to connect to Ksql Server by running the following command, after that we will be using the terminal of ksqldb client created here.

```bash
> docker-compose exec ksqldb-cli  ksql http://primary-ksqldb-server:8088
```


### Create Source Connector

To mockup the test data:

```bash
$> cat .\datafeed\sql\frankfurt.sql | docker exec -i 2ba9f8d475e9 bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $Password!'
```

The script for the source connector is avaliable at  [friday-connector.json](/kafka/connectors/friday-connector.json)

```bash
$> curl -H "Accept:application/json" localhost:8083/connectors/
$> curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @friday-connector.json
```


After that you should be able to see the topics for the tables residing in the stock schema at mssql.

```bash
ksql> show topics;
```

> **_NOTE:_** In order to keep the offset at begining during the demo please run the following command!
>
>```bash
>ksql> SET 'auto.offset.reset' = 'earliest';
>````


### Create Transformations with Streams and Tables
Run the following script which is avaliable in [tick-avro.sql](/kafka/ksql/transforms/TickAvro.sql) creating stream and tables for the transformation.



### Create Sink Connector
[...]
