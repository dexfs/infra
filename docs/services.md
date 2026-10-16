# Services Overview

Brief description of every service in this stack and when to use each one.

---

## Data Stores

### PostgreSQL
**Port:** `5432`

Relational database. Stores structured data with strong ACID guarantees. Use it for anything that benefits from schemas, foreign keys, joins, and transactions — user records, orders, financial data, anything with clear relationships.

### MongoDB
**Port:** `27017`

Document database. Stores data as JSON-like documents with flexible, schema-less structure. Use it when your data shape varies per record, for nested/hierarchical data, or when you want to iterate quickly without migrations.

### Redis
**Port:** `6379`

In-memory key-value store. Extremely fast reads and writes. Use it for caching, session storage, rate limiting, leaderboards, pub/sub messaging, and any data that either expires or needs sub-millisecond access.

### Elasticsearch
**Port:** `9200`

Distributed search and analytics engine. Use it for full-text search, log aggregation, faceted filtering, autocomplete, and complex aggregations over large datasets. Built on top of Apache Lucene.

---

## Messaging

### Kafka
**Port:** `9092` (host) / `29092` (internal)

Distributed event streaming platform. Use it for high-throughput, durable, ordered event streams — event sourcing, audit logs, data pipelines, and decoupling services that need replay or fan-out at scale.

### Zookeeper
**Port:** `2181` (internal only)

Coordination service required by Kafka (this image). Manages broker metadata, leader election, and cluster state. You don't interact with it directly.

### RabbitMQ
**Port:** `5672` (AMQP) / `15672` (management UI)

Message broker. Use it for task queues, work distribution, and RPC patterns. Simpler than Kafka for point-to-point and pub/sub workflows where you don't need long-term message retention or replay.

---

## AWS Emulation

### Floci
**Port:** `4566`

Open-source local AWS emulator. Drop-in replacement for LocalStack Community (which was sunset in March 2026). Emulates S3, SQS, SNS, DynamoDB, Lambda, API Gateway, Cognito, and many more services. Point your AWS SDK or CLI at `http://localhost:4566` with any dummy credentials.

---

## UIs & Management

### Kafka UI
**Port:** `8080` — http://localhost:8080

Web interface for Kafka. Browse topics, inspect messages, monitor consumer groups, and manage cluster configuration without the CLI.

### Mongo Express
**Port:** `8081` — http://localhost:8081

Web interface for MongoDB. Browse databases and collections, run queries, insert and delete documents.

### Kibana
**Port:** `5601` — http://localhost:5601

Web interface for Elasticsearch. Build queries, visualize data, create dashboards, and explore logs indexed in Elasticsearch.

---

## Observability (`docker-compose.observability.yml`)

### Prometheus
**Port:** `9090` — http://localhost:9090

Metrics collection and storage. Scrapes metrics from instrumented services at regular intervals and stores them as time-series data. Query with PromQL directly or via Grafana.

### Alertmanager
**Port:** `9093` — http://localhost:9093

Handles alerts fired by Prometheus. Routes, deduplicates, groups, and silences alerts. Configured to a null receiver by default — extend `config/observability/alertmanager/alertmanager.yml` to wire up email, Slack, PagerDuty, etc.

### Grafana Loki
**Port:** `3100` (API only)

Log aggregation system. Stores and indexes logs shipped by your applications. Designed to work alongside Prometheus — same label-based model, queryable with LogQL. Does not index log content, only metadata, keeping storage lean.

### Grafana Tempo
**Ports:** `3200` (API) / `4317` (OTLP gRPC) / `4318` (OTLP HTTP) / `14268` (Jaeger HTTP)

Distributed tracing backend. Receives traces in OTLP or Jaeger format and stores them for querying. Trace IDs can be correlated with Loki logs in Grafana. Point your OpenTelemetry SDK at `localhost:4317` (gRPC) or `localhost:4318` (HTTP).

### Grafana
**Port:** `3000` — http://localhost:3000 (`studies` / `studies`)

Observability dashboards. Prometheus, Loki, and Tempo are pre-wired as datasources. Use it to build dashboards, explore metrics and logs, and trace requests end-to-end.

### Node Exporter
**Port:** internal only

Exports host machine metrics (CPU, memory, disk, network) to Prometheus. No direct interaction needed — Prometheus scrapes it automatically.
