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


class ArCondicionadoStco(models.Model):
    ano = models.IntegerField()
    id_concessionaria = models.ForeignKey('Concessionarias', models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    qtd_frota_total = models.IntegerField(blank=True, null=True)
    qtd_frota_com_ar_condicionado = models.IntegerField(blank=True, null=True)
    pct_frota_com_ar_condicionado = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ar_condicionado_stco'


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


class DadosStco(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    passageiros_total = models.BigIntegerField(blank=True, null=True)
    passageiros_equivalente = models.BigIntegerField(blank=True, null=True)
    quilometragem_total = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    frota_operante = models.IntegerField(blank=True, null=True)
    viagens = models.DecimalField(max_digits=10, decimal_places=1, blank=True, null=True)
    desempenho_operacional = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    passageiros_por_viagem = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    passageiros_por_veiculo = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    kms_por_viagem = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'dados_stco'


class DemandaPaxPorPagamento(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    tipo_pagamento = models.CharField(max_length=50, blank=True, null=True)
    demanda = models.BigIntegerField(blank=True, null=True)
    demanda_int_metro = models.BigIntegerField(blank=True, null=True)
    demanda_int_stec = models.BigIntegerField(blank=True, null=True)
    demanda_int_brt = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'demanda_pax_por_pagamento'


class DistribuicaoTaxisPorTipoDeServico(models.Model):
    id_distribuicao_taxis_por_tipo_de_servico = models.AutoField(primary_key=True)
    ano = models.IntegerField(blank=True, null=True)
    tipo_de_servico = models.TextField(blank=True, null=True)
    entidade_operadora = models.TextField(blank=True, null=True)
    total_de_veiculos = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'distribuicao_taxis_por_tipo_de_servico'


class FrotaDeTaxis(models.Model):
    id_frota_taxis = models.AutoField(primary_key=True)
    ano = models.IntegerField(blank=True, null=True)
    taxis_comum_autonomos = models.IntegerField(blank=True, null=True)
    taxis_comum_empresas = models.IntegerField(blank=True, null=True)
    total_taxis_comum = models.IntegerField(blank=True, null=True)
    taxis_especiais = models.IntegerField(blank=True, null=True)
    total_geral = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'frota_de_taxis'


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


class HistoricoIdadeMediaFrota(models.Model):
    id_historico = models.AutoField(primary_key=True)
    ano = models.IntegerField(blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    idade_media = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico_idade_media_frota'


class HistoricoPassageirosTransportados(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    passageiros = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico_passageiros_transportados'


class HistoricoPassageirosTransportadosMetroAno(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    passageiros = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico_passageiros_transportados_metro_ano'


class HistoricoPassageirosTransportadosMetroMes(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    passageiros = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico_passageiros_transportados_metro_mes'


class HistoricoQuilometragemPercorrida(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    quilometragem = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico_quilometragem_percorrida'


class IdadeMediaDaFrota(models.Model):
    id_idade_media_mes = models.AutoField(primary_key=True)
    id_concessionaria = models.ForeignKey(Concessionarias, models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    mes = models.IntegerField(blank=True, null=True)
    ano = models.IntegerField(blank=True, null=True)
    idade_media = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'idade_media_da_frota'


class IdadeMediaDaFrotaDeTaxis(models.Model):
    id_idade_media_taxis = models.AutoField(primary_key=True)
    ano = models.IntegerField(blank=True, null=True)
    idade_media = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'idade_media_da_frota_de_taxis'


class IndicadoresFinanceirosStco(models.Model):
    id_concessionaria = models.ForeignKey(Concessionarias, models.DO_NOTHING, db_column='id_concessionaria', blank=True, null=True)
    tipo_conta = models.CharField(max_length=50, db_comment='Tipo de indicador financeiro (Receita Bruta, Receita Líquida, etc.)')
    ano = models.IntegerField(db_comment='Ano de referência do dado')
    valor = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    unidade_medida = models.CharField(max_length=20, blank=True, null=True, db_comment='Unidade de medida (R$, %)')
    fonte = models.CharField(max_length=100, blank=True, null=True, db_comment='Fonte dos dados')
    observacoes = models.TextField(blank=True, null=True, db_comment='Observações adicionais sobre o registro')

    class Meta:
        managed = False
        db_table = 'indicadores_financeiros_stco'
        unique_together = (('id_concessionaria', 'tipo_conta', 'ano'),)
        db_table_comment = 'Armazena os indicadores financeiros do Sistema de Transporte Coletivo por Ônibus (STCO)'


class SalarioMinimo(models.Model):
    ano = models.IntegerField()
    data_ajuste = models.DateField()
    valor_salario = models.DecimalField(max_digits=10, decimal_places=2)
    ato_legal = models.CharField(max_length=50)
    percentual_ajuste = models.DecimalField(max_digits=5, decimal_places=2)
    data_criacao = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'salario_minimo'
        unique_together = (('ano', 'data_ajuste'),)


class TarifaPrecoStco(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    valor = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    data_alteracao = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tarifa_preco_stco'


class TaxisPorCombustivel(models.Model):
    id_taxis_por_combustivel = models.AutoField(primary_key=True)
    ano = models.IntegerField(blank=True, null=True)
    tipo_combustivel = models.TextField(blank=True, null=True)
    quantidade = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'taxis_por_combustivel'


class TipoDeVeiculo(models.Model):
    id_tipo_veiculo = models.AutoField(primary_key=True)
    nome_tipo = models.CharField(max_length=60, blank=True, null=True)
    vida_util_em_anos = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tipo_de_veiculo'


class TiposVeiculosServicoTaxis(models.Model):
    id_tipos_veiculos_taxis = models.AutoField(primary_key=True)
    ano_registro = models.IntegerField(blank=True, null=True)
    mes_registro = models.IntegerField(blank=True, null=True)
    marca = models.TextField(blank=True, null=True)
    modelo = models.TextField(blank=True, null=True)
    quantidade = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tipos_veiculos_servico_taxis'


class VeiculosNovosAdquiridosPorAno(models.Model):
    ano = models.IntegerField(blank=True, null=True)
    veiculos = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'veiculos_novos_adquiridos_por_ano'