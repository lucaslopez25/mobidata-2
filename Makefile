.PHONY: load-data migrate backup-data

load-data:
	docker compose exec mobidata-app python manage.py create_database
	docker compose exec mobidata-app python manage.py load_sql_data

backup-data:
	docker compose exec -T mobidata-postgres pg_dump -U mobidatauser dados_mobilidade > backup_$$(date +%F_%H%M).sql