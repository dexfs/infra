.PHONY: up down restart ps logs clean

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

ps:
	docker compose ps

logs:
	docker compose logs -f

logs-%:
	docker compose logs -f $*

clean:
	docker compose down -v --remove-orphans

# ─── AWS (Floci) shortcuts ────────────────────────────────────────────────────
aws-ls-s3:
	aws --endpoint-url=http://localhost:4566 s3 ls

aws-create-bucket:
	aws --endpoint-url=http://localhost:4566 s3 mb s3://$(name)

aws-ls-sqs:
	aws --endpoint-url=http://localhost:4566 sqs list-queues

aws-create-queue:
	aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name $(name)
