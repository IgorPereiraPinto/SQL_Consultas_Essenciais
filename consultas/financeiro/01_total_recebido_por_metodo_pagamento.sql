/*
Consulta 01 — Total recebido por método de pagamento

O que significa:
- Soma quanto entrou (valores positivos) agrupando por método de pagamento.
- Ex.: PIX, Cartão, Boleto, etc.

Para que serve:
- Entender a composição do caixa por meio de pagamento.
- Apoiar negociação de taxas (cartão), estratégia de incentivo (PIX) e fluxo de recebimentos (boleto).

SQL 3C
Cliente: Financeiro / Gestão de Caixa
Consulta: "Quanto foi recebido por cada método de pagamento?"
Contexto:
- Tabela: lancamento
- Regra: considerar apenas entradas (valor > 0)
- Dimensão: metodo_pgto
- Métrica: SUM(valor)

Cuidados / Comentários:
- Se sua base mistura entradas e saídas no mesmo campo VALOR, o filtro (VALOR > 0) é essencial.
- Se existirem estornos/chargebacks, pode ser útil tratar como saídas ou categoria específica.
- Para análises por período, adicione filtro de data (ex.: data_lanc).
*/

SELECT
    metodo_pgto,
    SUM(valor) AS total
FROM lancamento
WHERE valor > 0
GROUP BY metodo_pgto
ORDER BY total DESC;
