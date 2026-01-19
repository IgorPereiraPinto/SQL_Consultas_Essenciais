/*
Consulta 01 — CTR por anúncio (Click-Through Rate)

O que significa:
- CTR (Click-Through Rate) mede a taxa de cliques em relação às impressões.
- Fórmula: (cliques / impressões) * 100

Para que serve:
- Comparar performance de criativos/anúncios.
- Decidir quais anúncios pausar, manter, testar ou escalar.
- Ajuda a identificar problemas de "criativo fraco" (muitas impressões, poucos cliques).

SQL 3C
Cliente: Time de Tráfego / Performance
Consulta: "Qual o CTR de cada anúncio e quais são os melhores?"
Contexto:
- Tabelas: anuncio (a) e desempenho_anuncio (d)
- Chave: d.id_anuncio = a.id_anuncio
- Métricas: SUM(impressões), SUM(cliques), CTR calculado
Cuidados:
- Evitar divisão por zero (quando impressões = 0).
- CTR alto não garante leads/vendas (avalia junto com conversão e custo).
- Se você quiser analisar por período, adicione filtro de data (ex.: d.data).

*/

SELECT
    a.nome,
    SUM(d.impressoes) AS impressoes,
    SUM(d.cliques) AS cliques,
    ROUND(
        (SUM(d.cliques) * 100.0) / NULLIF(SUM(d.impressoes), 0)
    , 2) AS ctr
FROM anuncio a
JOIN desempenho_anuncio d
    ON d.id_anuncio = a.id_anuncio
GROUP BY a.nome
ORDER BY ctr DESC;
