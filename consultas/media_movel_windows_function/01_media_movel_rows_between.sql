/*
Tema: Window Functions — Média Móvel (Moving Average) com ROWS BETWEEN

Este arquivo traz 2 formas comuns de calcular média móvel usando Window Functions.

Base exemplo:
- tabela: cap12.vendas
- colunas: funcionario, ano, mes, unidades_vendidas

Pré-requisito:
- Banco com suporte a Window Functions (ex.: MySQL 8+, Postgres, SQL Server).

========================================================
QUERY A) Média móvel "centralizada" (anterior + atual + próximo)
========================================================
O que significa:
- Calcula a média considerando 3 pontos:
  mês anterior, mês atual e mês seguinte.
- Isso gera uma curva bem “suavizada”, porque usa informação dos dois lados.

Quando usar:
✅ Análises históricas (pós-período) onde você já tem todos os dados do intervalo
✅ Visualização/relatório para entender tendência “no meio” da série
✅ Suavização para gráficos e storytelling (quando não é previsão)

Quando NÃO usar:
⚠️ Operação do dia a dia / monitoramento em tempo real
⚠️ Forecasting (porque usa o mês seguinte — “futuro”)

Como funciona:
- PARTITION BY funcionario: calcula separado por funcionário
- ORDER BY ano, mes: ordena no tempo
- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING: janela de 3 linhas

*/

SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND(
        AVG(unidades_vendidas) OVER (
            PARTITION BY funcionario
            ORDER BY ano, mes
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        )
    , 2) AS media_movel_3p_centralizada
FROM cap12.vendas;


/*
========================================================
QUERY B) Média móvel "somente passado" (2 anteriores + atual)
========================================================
O que significa:
- Calcula a média considerando apenas informações já conhecidas até o momento:
  dois meses anteriores + mês atual.
- É uma média móvel mais adequada para acompanhamento operacional.

Quando usar:
✅ Monitoramento e dashboards do mês atual (sem olhar “o futuro”)
✅ Regras de negócio, alertas e acompanhamento de performance
✅ Base para modelos simples de tendência (SMA) e previsões

Quando NÃO usar:
⚠️ Se você quer uma suavização “central” perfeita para gráficos históricos,
   a centralizada pode ficar visualmente melhor.

Como funciona:
- PARTITION BY funcionario: calcula separado por funcionário
- ORDER BY ano, mes: ordena no tempo
- ROWS BETWEEN 2 PRECEDING AND CURRENT ROW: janela de 3 linhas (passado + atual)

*/

SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND(
        AVG(unidades_vendidas) OVER (
            PARTITION BY funcionario
            ORDER BY ano, mes
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        )
    , 2) AS media_movel_3p_passado
FROM cap12.vendas;


/*
========================================================
Diferença prática entre as duas
========================================================

1) Janela usada
- Centralizada (A):  [mês-1, mês, mês+1]  → usa o futuro
- Passado (B):       [mês-2, mês-1, mês]  → só usa dados disponíveis

2) Melhor para
- (A) Análise histórica e visualização (suavização "bonita")
- (B) Acompanhamento operacional e forecasting simples

3) Observação de qualidade de dados
- Se existir mais de uma linha por (funcionario, ano, mes), você pode distorcer a média.
  Nesse caso, agregue antes por mês (ex.: SUM(unidades_vendidas) por mês) e depois aplique a janela.
*/
