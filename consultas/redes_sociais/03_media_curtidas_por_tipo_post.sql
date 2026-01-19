/*
Consulta 03 — Média de curtidas por tipo de post

O que significa:
- Calcula a média de curtidas por tipo de post (Reel, Carrossel, Foto, etc.).
- Ajuda a entender qual formato gera mais curtidas em média.

Para que serve:
- Decidir onde concentrar esforço (ex.: Reel vs Carrossel).
- Otimizar calendário editorial e mix de formatos.
- Apoiar testes A/B (tipos de post, horários, temas).

SQL 3C
Cliente: Social Media / Conteúdo
Consulta: "Quais tipos de post geram mais curtidas em média?"
Contexto:
- Tabelas: post (p) e engajamento_diario (e)
- Chave: e.id_post = p.id_post
- Dimensão: p.tipo
- Métrica: AVG(curtidas) por tipo
Cuidados / Comentários:
- Se você quer “média por post” (e não por dia), pode precisar agregar por post antes.
- Para analisar período, adicione filtro em e.data_ref.
*/

SELECT
    p.tipo,
    ROUND(AVG(e.curtidas), 2) AS media_curtidas
FROM post p
JOIN engajamento_diario e
    ON e.id_post = p.id_post
GROUP BY p.tipo
ORDER BY media_curtidas DESC;
