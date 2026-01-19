/*
Consulta 02 — Total gasto por cliente

SQL 3C
Cliente: CRM / Comercial
Consulta: "Quanto cada cliente já gastou no total (R$) no e-commerce?"
Contexto:
- Tabelas: cliente (c) e pedido (ped)
- Chave: ped.id_cliente = c.id_cliente
- Métrica: SUM(valor_total) por cliente
Quando usar:
- Ranking de clientes mais valiosos (LTV básico)
- Ações de retenção, relacionamento e upsell
- Segmentação (VIP, alto valor, etc.)
Cuidados:
- Se houver clientes com mesmo nome, agrupar por nome pode misturar pessoas.
  Ideal: agrupar por ID e exibir o nome.
- Se quiser analisar por período, adicione filtro em ped.data_pedido.
*/

SELECT
    c.nome AS cliente,
    SUM(ped.valor_total) AS total_gasto
FROM cliente c
JOIN pedido ped
    ON ped.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY total_gasto DESC;
