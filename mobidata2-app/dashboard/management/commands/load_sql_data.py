import os # leitura das variáveis de ambiente, no caso, SQL_DIR

from pathlib import Path
from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from django.db import connections


class Command(BaseCommand):
    help = "Apply all sql files in sql/*.sql to dados_mobilidade, in alphabetical order."

    def add_arguments(self, parser):
        parser.add_argument(
            "--dry-run",
            action="store_true",
            help="List the files that would be applied, without executing them.",
        )
        parser.add_argument(
            "--only",
            type=str,
            default=None,
            help="Apply only one file (example: 04_comparativo_frota_stco.sql).",
        )

    def handle(self, *args, **options):
        sql_dir = Path(os.environ.get("SQL_DIR", Path(settings.BASE_DIR).parent / "sql"))
        # Mantém caminho secundário caso o comando de gestão seja executado fora do contêiner Docker

        if not sql_dir.is_dir():
            raise CommandError(f"Folder NOT FOUND: {sql_dir}")

        files = sorted(sql_dir.glob("*.sql"))

        if options["only"]:
            files = [f for f in files if f.name == options["only"]]
            if not files:
                raise CommandError(f"FILE NOT FOUND: {options['only']}")

        if options["dry_run"]:
            for f in files:
                self.stdout.write(f"  {f.name}")
            return

        conn = connections["dados_db"]
        for f in files:
            self.stdout.write(self.style.MIGRATE_HEADING(f"--> {f.name}"))
            sql = f.read_text(encoding="utf-8")
            with conn.cursor() as cur:
                cur.execute(sql)

        self.stdout.write(self.style.SUCCESS(
            f"{len(files)} file(s) applied to dados_mobilidade."
        ))