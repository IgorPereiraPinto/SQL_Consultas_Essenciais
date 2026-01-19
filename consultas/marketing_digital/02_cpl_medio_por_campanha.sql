/*
Consulta 02 — CPL médio por campanha (Cost Per Lead)

O que significa:
- CPL é o custo médio para gerar 1 lead.
- Fórmula: custo_total / leads_total

Para que serve:
- Medir eficiência das campanhas (quanto custa captar um lead).
- Rebalancear orçamento: investir mais no que traz lead mais barato (sem perder qualidade).
- Comparar campanhas diferentes de forma justa.

SQL 3C
Cliente: Time de Tráfego / Growth / Marketing
Consulta: "Qual o CPL médio de cada campanha?"
Contexto:
- Tabelas: campanha (c), anuncio (a), desempenho_anuncio (d)
- Chaves:
  - a.id_campanha = c.id_campanha
  - d.id_anuncio = a.id_anuncio
- Métricas: SUM(custo), SUM(leads), CPL calculado
Cuidados:
- Evitar divisão por zero (quando leads = 0).
- CPL baixo pode ser lead ruim (sempre cruzar com qualidade: MQL/SQL, conversão, vendas).
- Se existir múltiplas moedas/custos, padronize.
- Para análise temporal, adicione filtro por data em d.data.

*/

SELECT
    c.nome AS campanha,
    ROUND(
        SUM(d.custo) / NULLIF(SUM(d.leads), 0)
    , 2) AS cpl
FROM campanha c
JOIN anuncio a
    ON a.id_campanha = c.id_campanha
JOIN desempenho_anuncio d
    ON d.id_anuncio = a.id_anuncio
GROUP BY c.nome
ORDER BY cpl;
