# Cenários de Teste

### CT01 — Aplicar cupom BEMVINDO10

**Data:** 07/10/2026

**Status:** APROVADO

**Resultado esperado:** Aplicação de 10% de desconto sobre o subtotal de R$ 100,00.

**Resultado obtido:** O sistema aplicou corretamente o desconto de R$ 10,00, resultando em R$ 90,00 de produtos após o desconto. Com frete de R$ 19,90, o total do pedido foi R$ 109,90.

**Evidência:** `evidencias/CT01-cupom-bemvindo10.png`

**Conclusão:** Comportamento conforme o critério de aceitação CA01.

### CT02 — Validar letras maiúsculas, minúsculas e espaços no cupom

**Data:** 07/10/2026

**Critério de aceitação:** CA02

**Status:** APROVADO

**Resultado esperado:** O sistema deve aceitar o cupom independentemente de letras maiúsculas, minúsculas e espaços no início ou no final.

**Resultado obtido:** O sistema reconheceu as três variações testadas, padronizando a exibição do cupom para BEMVINDO10 e aplicando corretamente o desconto de R$ 10,00 sobre o subtotal de R$ 100,00.

**Evidências:**
- `evidencias/CT02-cupom-letras-minúsculas.png`
- `evidencias/CT02-cupom-espaços.png`
- `evidencias/CT02-cupom-letrasmaiúsculas-minúsculas.png`

### CT03 — Validar cupom inexistente

**Data:** 07/10/2026

**Critério de aceitação:** CA03

**Status:** APROVADO

**Cupom utilizado:** CUPOM20

**Resultado esperado:** O sistema deverá apresentar a mensagem "Cupom inválido." e não aplicar nenhum desconto.

**Resultado obtido:** O sistema apresentou corretamente a mensagem "Cupom inválido.", mantendo o desconto em R$ 0,00. O subtotal permaneceu em R$ 100,00, com frete de R$ 19,90 e total de R$ 119,90.

**Evidência:** `evidencias/CT03-cupom-invalido.png`

**Conclusão:** Comportamento conforme o critério de aceitação CA03.

**Conclusão:** Comportamento conforme o critério de aceitação CA02.
