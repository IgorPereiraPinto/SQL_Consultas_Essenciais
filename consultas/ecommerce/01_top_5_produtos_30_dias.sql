/*
Consulta 01 — Top 5 produtos mais vendidos (últimos 30 dias)

SQL 3C
Cliente: Comercial / E-commerce
Consulta: "Quais são os 5 produtos mais vendidos (em quantidade) nos últimos 30 dias?"
Contexto:
- Tabelas: pedido (ped) e produto (p)
- Chave: ped.id_produto = p.id_produto
- Filtro de período: data_pedido >= últimos 30 dias (janela móvel)
- Métrica: SUM(quantidade) por produto
Quando usar:
- Identificar produtos de maior giro no curto prazo
- Apoiar decisões de estoque, campanhas e vitrine do e-commerce
Cuidados:
- Em bases reais, muitas vezes existe pedido_item; ajuste o nível de granularidade para evitar duplicidade.
- Se seu objetivo for "mês atual", troque a regra de data.
*/

SELECT
    p.nome AS produto,
    SUM(ped.quantidade) AS total_vendido
FROM pedido ped
JOIN produto p
    ON p.id_produto = ped.id_produto
WHERE ped.data_pedido >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 5;
