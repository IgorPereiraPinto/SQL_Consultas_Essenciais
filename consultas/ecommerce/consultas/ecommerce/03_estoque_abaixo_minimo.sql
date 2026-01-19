/*
Consulta 03 — Produtos com estoque abaixo do mínimo

SQL 3C
Cliente: Operações / Estoque
Consulta: "Quais produtos estão com estoque atual abaixo do estoque mínimo?"
Contexto:
- Tabela: produto (p)
- Campos: estoque_atual e estoque_minimo
Quando usar:
- Alertas de ruptura (falta de produto)
- Rotina diária/semana de reposição
- Priorizar compras e abastecimento
Sugestões:
- Adicionar coluna de déficit (estoque_minimo - estoque_atual) para priorização.
*/

SELECT
    nome,
    estoque_atual,
    estoque_minimo,
    (estoque_minimo - estoque_atual) AS deficit
FROM produto
WHERE estoque_atual < estoque_minimo
ORDER BY estoque_atual ASC;
