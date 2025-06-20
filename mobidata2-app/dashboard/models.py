# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AquisicoesDeOnibusPorMes(models.Model):
    id_aquisicao_mes = models.AutoField(primary_key=True)
    id_concessionaria = models.ForeignKey('Concessionarias', models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    ano = models.IntegerField(blank=True, null=True)
    qtd_onibus = models.IntegerField(blank=True, null=True)
    novo_ou_usado = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'aquisicoes_de_onibus_por_mes'


class Concessionarias(models.Model):
    id_concessionaria = models.CharField(primary_key=True, max_length=10)
    nome_concessionaria = models.CharField(max_length=60, blank=True, null=True)
    endereco_garagens = models.CharField(max_length=255, blank=True, null=True)
    cep = models.CharField(max_length=10, blank=True, null=True)
    telefone = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'concessionarias'


class CorredoresDeOnibus(models.Model):
    id_corredor = models.AutoField(primary_key=True)
    nome_corredor = models.CharField(max_length=255, blank=True, null=True)
    qtd_onibus_por_hora = models.IntegerField(blank=True, null=True)
    extensao_em_kms = models.FloatField(blank=True, null=True)
    qtd_linhas_convencionais = models.IntegerField(blank=True, null=True)
    ano = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'corredores_de_onibus'


class FrotaOperante(models.Model):
    id_frota_operante_mes = models.AutoField(primary_key=True)
    id_concessionaria = models.ForeignKey(Concessionarias, models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    ano = models.IntegerField(blank=True, null=True)
    qtd_operante_de_onibus = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'frota_operante'


class FrotaTotal(models.Model):
    id_frota_total_mes = models.AutoField(primary_key=True)
    id_concessionaria = models.ForeignKey(Concessionarias, models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    ano = models.IntegerField(blank=True, null=True)
    qtd_total_de_onibus = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'frota_total'


# ALTERADA
class HistoricoIdadeMediaFrota(models.Model):
    id_historico = models.AutoField(primary_key=True)
    ano = models.IntegerField(blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    idade_media = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico_idade_media_frota'

    def __str__(self):
        return f"{self.ano}-{self.mes:02d}: {self.idade_media}"


class IdadeMediaDaFrota(models.Model):
    id_idade_media_mes = models.AutoField(primary_key=True)
    id_concessionaria = models.ForeignKey(Concessionarias, models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    ano = models.IntegerField(blank=True, null=True)
    idade_media = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'idade_media_da_frota'


class TipoDeVeiculo(models.Model):
    id_tipo_veiculo = models.AutoField(primary_key=True)
    nome_tipo = models.CharField(max_length=60, blank=True, null=True)
    vida_util_em_anos = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tipo_de_veiculo'