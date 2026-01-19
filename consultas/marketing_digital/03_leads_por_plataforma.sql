/*
Consulta 03 — Leads por plataforma

O que significa:
- Soma o total de leads gerados por plataforma (ex.: Meta, Google, LinkedIn).
- Mostra "qual canal está trazendo mais leads" (em volume).

Para que serve:
- Comparar contribuição de canais e apoiar distribuição de verba.
- Identificar dependência de um canal (risco operacional).
- Direcionar testes: onde vale otimizar criativo/segmentação.

SQL 3C
Cliente: Time de Tráfego / Performance
Consulta: "Quantos leads cada plataforma gerou?"
Contexto:
- Tabelas: anuncio (a) e desempenho_anuncio (d)
- Chave: d.id_anuncio = a.id_anuncio
- Dimensão: a.plataforma
- Métrica: SUM(leads)
Cuidados:
- Leads em volume não significam qualidade (cruzar com CPL e conversão).
- Se uma plataforma tem vários tipos de campanha, pode valer segmentar por campanha também.
- Para análise por período, adicione filtro de data (ex.: d.data).

*/

SELECT
    a.plataforma,
    SUM(d.leads) AS total_leads
FROM anuncio a
JOIN desempenho_anuncio d
    ON d.id_anuncio = a.id_anuncio
GROUP BY a.plataforma
ORDER BY total_leads DESC;
