/*
Consulta 02 — Boletos pendentes (inadimplência)

O que significa:
- Lista lançamentos do tipo Boleto que ainda estão com status Pendente.
- Isso vira a “fila de cobrança” do financeiro.

Para que serve:
- Acompanhar inadimplência e agir rápido (cobrar antes de virar atraso longo).
- Priorizar cobrança por valor e data.
- Base para rotina diária do contas a receber.

SQL 3C
Cliente: Financeiro / Cobrança
Consulta: "Quais boletos ainda não foram pagos?"
Contexto:
- Tabela: lancamento
- Filtros:
  - metodo_pgto = 'Boleto'
  - status = 'Pendente'
- Campos: descricao, valor, data_lanc

Cuidados / Comentários:
- Em bases reais, pode existir 'Vencimento'. Se tiver, use a data de vencimento no lugar de data_lanc.
- Vale ordenar por data (mais antigos primeiro) ou por valor (maiores primeiro).
- Se a sua base usa status diferentes (ex.: 'Aberto', 'Em aberto'), ajuste o filtro.
*/

SELECT
    descricao,
    valor,
    data_lanc
FROM lancamento
WHERE metodo_pgto = 'Boleto'
  AND status = 'Pendente';
