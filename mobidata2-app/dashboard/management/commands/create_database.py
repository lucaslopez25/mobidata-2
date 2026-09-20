from django.core.management.base import BaseCommand
from django.db import connections


class Command(BaseCommand):
    help = "Create dados_mobilidade database if it does not exist yet."

    def handle(self, *args, **options):
        conn = connections["default"]
        with conn.cursor() as cur:
            cur.execute(
                "SELECT 1 FROM pg_database WHERE datname = %s",
                ["dados_mobilidade"],
            )
            if cur.fetchone():
                self.stdout.write("Database dados_mobilidade already exists.")
                return
            cur.execute("CREATE DATABASE dados_mobilidade")
            self.stdout.write(self.style.SUCCESS(
                "Created dados_mobilidade database."
            ))