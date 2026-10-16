.PHONY: up down restart ps logs clean obs-up obs-down obs-logs obs-clean

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

# ─── Observability ───────────────────────────────────────────────────────────
obs-up:
	docker compose -f docker-compose.observability.yml up -d

obs-down:
	docker compose -f docker-compose.observability.yml down

obs-logs:
	docker compose -f docker-compose.observability.yml logs -f

obs-logs-%:
	docker compose -f docker-compose.observability.yml logs -f $*

obs-clean:
	docker compose -f docker-compose.observability.yml down -v --remove-orphans

# ─── AWS (Floci) shortcuts ────────────────────────────────────────────────────
aws-ls-s3:
	aws --endpoint-url=http://localhost:4566 s3 ls

aws-create-bucket:
	aws --endpoint-url=http://localhost:4566 s3 mb s3://$(name)

aws-ls-sqs:
	aws --endpoint-url=http://localhost:4566 sqs list-queues

aws-create-queue:
	aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name $(name)
