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

### CT04 — Validar cupom expirado

**Data:** 07/10/2026

**Critério de aceitação:** CA04

**Status:** APROVADO

**Cupom utilizado:** VERAO2026 — expirado em 31/03/2026.

**Resultado esperado:** O sistema deverá apresentar a mensagem "Cupom expirado." e não aplicar desconto.

**Resultado obtido:** O sistema identificou corretamente o cupom expirado, exibindo a mensagem "Cupom expirado.". O desconto permaneceu em R$ 0,00, com subtotal de R$ 100,00, frete de R$ 19,90 e total de R$ 119,90.

**Evidência:** `evidencias/CT04-cupom-expirado.png`

### CT05 — Validar substituição de cupom aplicado

**Data:** 07/10/2026

**Critério de aceitação:** CA05

**Status:** PARCIALMENTE EXECUTADO

**Resultado esperado:** O sistema deve permitir apenas um cupom por vez. Para substituir o cupom atual, o cliente deverá removê-lo e aplicar outro cupom válido.

**Resultado obtido:** Foi confirmado que, após aplicar o cupom BEMVINDO10, o sistema apresenta apenas a opção "Remover cupom", sem disponibilizar um campo para aplicar outro simultaneamente.

**Limitação:** A documentação disponibiliza apenas dois cupons: BEMVINDO10 (válido) e VERAO2026 (expirado). Portanto, não foi possível validar a substituição por outro cupom válido.

**Evidência:** `evidencias/CT05-substituicao-cupom.png`

**Conclusão:** A restrição de um cupom por vez foi observada. A substituição por outro cupom válido permanece pendente por falta de massa de teste.

**Conclusão:** Comportamento conforme o critério de aceitação CA04.

# BUG-001 — Frete grátis não aplicado ao atingir R$ 200,00

**Data:** 07/10/2026

**Critério de aceitação:** CA06

**Caso de teste:** CT06

**Severidade sugerida:** Alta

**Descrição:** Ao atingir o subtotal de R$ 200,00, o sistema continua cobrando R$ 19,90 de frete, contrariando a regra de frete grátis para compras a partir de R$ 200,00.

**Pré-condições:** Carrinho com produtos e sem cupom aplicado.

**Passos para reprodução:**
1. Adicionar 4 unidades da Garrafa Térmica 750ml, no valor de R$ 50,00 cada.
2. Acessar o carrinho.
3. Verificar o subtotal, o frete e o total do pedido.

**Resultado esperado:** Frete grátis (R$ 0,00) e total de R$ 200,00.

**Resultado obtido:** Frete de R$ 19,90 e total de R$ 219,90. O sistema ainda apresenta a mensagem "Faltam R$ 0,00 para o frete grátis".

**Status:** Aberto

**Validação complementar:** Ao aumentar o subtotal para R$ 250,00, o sistema concedeu corretamente o frete grátis.

**Conclusão:** O defeito foi reproduzido no valor exato de R$ 200,00, enquanto o cenário de R$ 250,00 funcionou conforme esperado.

**Possível causa:** Utilização de uma comparação estrita (`> 200`) em vez de inclusiva (`>= 200`) na regra de frete grátis.

**Status do CT06:** REPROVADO — BUG-001.

**Evidências:**
- `evidencias/CT06-frete-gratis-200.png`
- `evidencias/CT06-frete-gratis-250.png`

**Evidência:** `evidencias/CT06-frete-gratis-200.png`
