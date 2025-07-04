class DadosRouter:

    def db_for_read(self, model, **hints):
        if model._meta.app_label == 'dashboard':
            return 'dados_db'
        return 'default'

    def db_for_write(self, model, **hints):
        if model._meta.app_label == 'dashboard':
            return 'dados_db'
        return 'default'

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        if app_label == 'dashboard':
            return db == 'dados_db'
        return 'default'
