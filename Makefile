.PHONY: test catalog db-up db-down

test:
	python -m unittest discover -s tests -v

catalog:
	python tools/check_catalog.py

db-up:
	docker compose up -d

db-down:
	docker compose down
