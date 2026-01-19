/*
Consulta 02 — Crescimento diário de seguidores (SQL avançado)

O que significa:
- Mostra a variação diária de seguidores comparando o dia atual com o dia anterior.
- Usa LAG para pegar o valor do dia anterior.

Para que serve:
- Encontrar dias de pico (saltos) e cruzar com ações/campanhas.
- Entender tendência (crescimento constante vs. quedas).
- Base para relatórios de Growth e performance orgânica.

SQL 3C
Cliente: Social Media / Growth
Consulta: "Como está o crescimento diário da base de seguidores?"
Contexto:
- Tabela: seguidor
- Campos: data_ref, qtd_seguidores
- Janela: LAG(qtd_seguidores) ordenado por data_ref
Cuidados / Comentários:
- Requer MySQL 8+ (por causa da função de janela).
- O primeiro dia não terá “dia anterior” → crescimento fica NULL.
- Se houver mais de uma linha por data, agregue antes (GROUP BY data_ref).
*/

SELECT
    data_ref,
    qtd_seguidores,
    qtd_seguidores - LAG(qtd_seguidores) OVER (ORDER BY data_ref) AS crescimento
FROM seguidor;
