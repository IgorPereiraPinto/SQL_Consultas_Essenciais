/*
Consulta 01 — Top posts por engajamento total

O que significa:
- Calcula o engajamento total por post somando:
  curtidas + comentários + compartilhamentos
- Retorna os 5 posts com maior engajamento (ranking).

Para que serve:
- Identificar quais conteúdos “puxam” mais interação.
- Guiar linha editorial (temas, formatos e abordagem).
- Base para repetir padrões vencedores e ajustar os fracos.

SQL 3C
Cliente: Social Media / Marketing de Conteúdo
Consulta: "Quais posts geraram mais engajamento total?"
Contexto:
- Tabelas: post (p) e engajamento_diario (e)
- Chave: e.id_post = p.id_post
- Métrica: SUM(curtidas + comentarios + compartilhamentos)
Cuidados / Comentários:
- Em dados reais, um post pode ter vários dias de engajamento → o SUM agrega tudo (ok).
- Se você quiser analisar por período (últimos 30 dias), adicione filtro em e.data_ref.
*/

SELECT
    p.titulo,
    SUM(e.curtidas + e.comentarios + e.compartilhamentos) AS engajamento_total
FROM post p
JOIN engajamento_diario e
    ON e.id_post = p.id_post
GROUP BY p.titulo
ORDER BY engajamento_total DESC
LIMIT 5;
