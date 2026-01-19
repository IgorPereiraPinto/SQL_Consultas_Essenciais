/*
Consulta 03 — Gastos por categoria

O que significa:
- Soma os valores de SAÍDA (despesas) agrupando por categoria.
- Traz um ranking de onde a empresa mais gasta.

Para que serve:
- Visão executiva de despesas (corte de custo e eficiência).
- Identificar categorias “vilãs” do orçamento.
- Base para orçamento mensal e análise de variações.

SQL 3C
Cliente: Financeiro / Diretoria
Consulta: "Quanto está sendo gasto em cada categoria?"
Contexto:
- Tabelas: lancamento (lan) e categoria (cat)
- Chave: cat.id_categoria = lan.id_categoria
- Filtro: cat.tipo = 'Saída' (considerar apenas despesas)
- Métrica: SUM(lan.valor)

Cuidados / Comentários:
- Dependendo do modelo, despesas podem estar como valor negativo em 'lan.valor'.
  Se for o seu caso, ajuste para SUM(ABS(lan.valor)) ou filtre (lan.valor < 0).
- Se houver categorias mal cadastradas, você pode ter gasto indo para 'Outros' demais.
*/

SELECT
    cat.nome AS categoria,
    SUM(lan.valor) AS total_gasto
FROM lancamento lan
JOIN categoria cat
    ON cat.id_categoria = lan.id_categoria
WHERE cat.tipo = 'Saída'
GROUP BY cat.nome
ORDER BY total_gasto DESC;
