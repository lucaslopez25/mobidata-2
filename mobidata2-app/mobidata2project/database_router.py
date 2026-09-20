class DadosRouter:
    """
    Roteia os models do app 'dashboard' para o banco dados_db (leitura e escrita)
    e mantém o resto do Django (auth, admin, sessions, contenttypes) no default.
    """

    APP_DADOS = "dashboard"
    DB_DADOS = "dados_db"
    DB_DEFAULT = "default"

    def db_for_read(self, model, **hints):
        if model._meta.app_label == self.APP_DADOS:
            return self.DB_DADOS
        return self.DB_DEFAULT

    def db_for_write(self, model, **hints):
        if model._meta.app_label == self.APP_DADOS:
            return self.DB_DADOS
        return self.DB_DEFAULT

    def allow_relation(self, obj1, obj2, **hints):
        if obj1._meta.app_label == self.APP_DADOS or \
           obj2._meta.app_label == self.APP_DADOS:
            return obj1._meta.app_label == obj2._meta.app_label
        return None

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        if app_label == self.APP_DADOS:
            return db == self.DB_DADOS
        return db == self.DB_DEFAULT