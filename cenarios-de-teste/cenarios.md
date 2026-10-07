# Cenários de Teste

| ID | Cenário | Resultado esperado | Status |
|---|---|---|---|
| CT01 | Aplicar cupom BEMVINDO10 | Aplicar 10% de desconto | Passou |
| CT02 | Cupom com minúsculas e espaços | Cupom deve ser reconhecido | Passou |
| CT03 | Cupom inexistente | Retornar "Cupom inválido." sem desconto | Passou |
| CT04 | Cupom VERÃO2026 expirado | Retornar "Cupom expirado." sem desconto | Passou |
| CT05 | Subtotal abaixo de R$ 200 | Cobrar R$ 19,90 de frete | Passou |
| CT06 | Subtotal a partir de R$ 200 | Frete grátis | Passou |
| CT07 | Aplicar desconto com frete grátis | Frete considera subtotal antes do desconto | Passou |
| CT08 | Quantidade acima de 5 | Retornar erro QUANTIDADE_MAXIMA_EXCEDIDA | Passou |
| CT09 | Produto duplicado | Retornar erro ITEM_DUPLICADO | Passou |
| CT10 | JSON inválido | Retornar 400 JSON_INVALIDO | Passou |
| CT11 | Validar arredondamento | Valores com 2 casas decimais | Passou |
