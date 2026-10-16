# infra

Local development dependencies for software engineering studies.

## Services

| Service | Port(s) | Credentials |
|---|---|---|
| PostgreSQL | `5432` | `studies` / `studies` |
| Redis | `6379` | — |
| Kafka | `9092` | — |
| Kafka UI | `8080` | http://localhost:8080 |
| RabbitMQ AMQP | `5672` | `studies` / `studies` |
| RabbitMQ Management | `15672` | http://localhost:15672 |
| Floci (AWS emulator) | `4566` | key: `test` / secret: `test` |

## Usage

```bash
# Start all services
make up

# Stop all services
make down

# View logs (all)
make logs

# View logs for a specific service
make logs-kafka

# Show running containers
make ps

# Stop and remove volumes (full reset)
make clean
```

## AWS (Floci)

Floci is a free, open-source LocalStack drop-in replacement. Point your AWS SDK or CLI at `http://localhost:4566`.

**AWS CLI:**
```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1

# S3
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket
aws --endpoint-url=http://localhost:4566 s3 ls

# SQS
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name my-queue
aws --endpoint-url=http://localhost:4566 sqs list-queues
```

**Makefile shortcuts:**
```bash
make aws-create-bucket name=my-bucket
make aws-ls-s3
make aws-create-queue name=my-queue
make aws-ls-sqs
```

**SDK configuration (any language):**
- Endpoint: `http://localhost:4566`
- Region: `us-east-1`
- Access key: `test`
- Secret key: `test`

## Kafka

Internal broker address (container-to-container): `kafka:29092`  
External address (host): `localhost:9092`

Kafka UI is available at http://localhost:8080.

## Environment variables

Copy `.env.example` to `.env` and adjust as needed:

```bash
cp .env.example .env
```

## References

| Tool | Link |
|---|---|
| Floci (AWS emulator) | https://github.com/floci-io/floci |
| Floci docs | https://floci.io/floci/ |
| Floci supported services | https://floci.io/floci/services/ |
| Floci migration from LocalStack | https://floci.io/floci/getting-started/migrate-from-localstack/ |
| Kafka UI | https://github.com/provectuslabs/kafka-ui |
| RabbitMQ Management Plugin | https://www.rabbitmq.com/docs/management |
| Confluent Platform (Kafka images) | https://hub.docker.com/r/confluentinc/cp-kafka |
