# Relatório de Evidências — Verzel Store

## 1. Objetivo

Este documento reúne as evidências dos testes manuais, exploratórios e de API realizados na Verzel Store em 07/10/2026.

O objetivo é demonstrar os resultados obtidos na validação das regras de negócio, incluindo cupons de desconto, frete, limite de quantidade, cálculos e validação de dados.

**Ambiente testado:** https://verzel-store.qa-test-verzel-store.workers.dev/

## 2. Resumo da execução

| Resultado | Quantidade |
|---|---:|
| Aprovados | 9 |
| Reprovados | 2 |
| Parcialmente executados | 1 |
| **Total** | **12** |

## 3. Cenários e evidências

### CT01 — Aplicar cupom BEMVINDO10

**Status:** APROVADO

O sistema aplicou corretamente 10% de desconto sobre R$ 100,00 em produtos. Com frete de R$ 19,90, o total foi R$ 109,90.

**Evidência:** [CT01 — Aplicação do cupom](CT01-cupom-bemvindo10.png)

### CT02 — Validar letras maiúsculas, minúsculas e espaços

**Status:** APROVADO

O sistema reconheceu as três variações do cupom BEMVINDO10, aplicando corretamente o desconto.

**Evidências:**

- [Letras minúsculas](CT02-cupom-letras-minúsculas.png)
- [Espaços](CT02-cupom-espaços.png)
- [Maiúsculas e minúsculas](CT02-cupom-letrasmaiúsculas-minúsculas.png)

### CT03 — Validar cupom inexistente

**Status:** APROVADO

O sistema apresentou a mensagem "Cupom inválido." e não aplicou desconto.

**Evidência:** [CT03 — Cupom inválido](CT03-cupom-invalido.png)

### CT04 — Validar cupom expirado

**Status:** APROVADO

O cupom VERAO2026 foi identificado como expirado, sem aplicação de desconto.

**Evidência:** [CT04 — Cupom expirado](CT04-cupom-expirado.png)

### CT05 — Validar substituição de cupom

**Status:** PARCIALMENTE EXECUTADO

Foi confirmado que a interface permite apenas um cupom aplicado por vez. Não foi possível testar a substituição por outro cupom válido, pois não havia uma segunda opção válida na massa de testes.

**Evidência:** [CT05 — Substituição de cupom](CT05-substituicao-cupom.png)

### CT06 — Validar frete grátis a partir de R$ 200,00

**Status:** REPROVADO — DEFEITO IDENTIFICADO

Com subtotal exatamente igual a R$ 200,00, o sistema cobrou R$ 19,90 de frete, contrariando a regra esperada.

Com subtotal de R$ 250,00, o frete grátis foi aplicado corretamente.

**Evidências:**

- [Subtotal R$ 200,00 — Falha](CT06-frete-gratis-200.png)
- [Subtotal R$ 250,00 — Comportamento correto](CT06-frete-gratis-250.png)

### CT07 — Validar frete fixo abaixo de R$ 200,00

**Status:** APROVADO

Com subtotal de R$ 150,00, o sistema cobrou corretamente R$ 19,90 de frete e informou que faltavam R$ 50,00 para atingir o frete grátis.

**Evidência:** [CT07 — Frete abaixo do limite](CT07-frete-abaixo-200.png)

### CT08 — Validar cálculo do frete antes do desconto

**Status:** APROVADO

Com subtotal de R$ 219,70 e desconto de R$ 21,97, o frete permaneceu grátis, conforme a regra de cálculo anterior à aplicação do desconto.

**Evidências:**

- [Frete antes do desconto](CT08-frete-antes-desconto.png)
- [Frete com desconto](CT08-frete-com-desconto.png)
- [Subtotal abaixo do limite após desconto](CT08-frete-abaixo-limite-apos-desconto.png)

### CT09 — Validar que o desconto não incide sobre o frete

**Status:** APROVADO

O desconto de 10% foi aplicado somente sobre o subtotal dos produtos, mantendo o frete integral de R$ 19,90.

**Evidência:** [CT09 — Desconto e frete](CT09-desconto-nao-incide-frete.png)

### CT10 — Validar limite máximo de 5 unidades por produto

**Status:** REPROVADO — DEFEITO IDENTIFICADO

A interface respeitou o limite de 5 unidades por produto. Entretanto, as APIs aceitaram quantidades superiores ao limite permitido.

**Resultados observados:**

- Interface: limite de 5 unidades respeitado.
- `/api/carrinho/calcular`: aceitou 10 unidades, retornando HTTP 200.
- `/api/pedidos`: aceitou 10 unidades, retornando HTTP 201.

**Evidências:**

- [API de pedidos — HTTP 201](CA10-%20BUG%20limite%20máximo%20pedido.png)
- [API de carrinho — HTTP 200](CA10-%20Bug%20limite%20máximo%20carrinho.png)
- [Interface — Limite de 5 unidades](CA10-%20Limite%20máximo%20interface.png)

### CT11 — Validar arredondamento dos valores

**Status:** APROVADO

A interface e a API apresentaram os mesmos valores:

| Campo | Valor |
|---|---:|
| Subtotal | R$ 179,70 |
| Desconto | R$ 17,97 |
| Frete | R$ 19,90 |
| Total | R$ 181,63 |

**Evidências:**

- [CT11 — Interface](CT11-arredondamento-interface.png)
- [CT11 — API](CT11-arredondamento-api.png)

### CT12 — Validar e-mail inválido

**Status:** APROVADO

Ao informar o e-mail inválido `@gmail.com`, o sistema apresentou corretamente a mensagem "Informe um e-mail válido".

**Evidência:** [CT12 — Validação de e-mail](CT12-validacao-email-invalido.png)

## 4. Defeitos identificados

### Defeito 1 — Frete grátis não aplicado exatamente em R$ 200,00

O sistema mantém a cobrança de frete quando o subtotal é exatamente igual ao limite estabelecido para frete grátis.

**Cenário relacionado:** CT06.

### Defeito 2 — API aceita quantidade superior a 5 unidades

Os endpoints de carrinho e pedidos aceitam quantidades superiores ao limite permitido pela interface.

**Cenário relacionado:** CT10.

Os detalhes dos defeitos e os passos de reprodução estão registrados nos cenários de teste e no arquivo [`bugs.md`](../../bugs.md).

## 5. Evidências da automação

Foram implementados três cenários automatizados utilizando Playwright.

| Cenário | Resultado |
|---|---|
| CT10 — Limite de quantidade | Falha conhecida |
| CT11 — Cálculo e arredondamento | Aprovado |
| CT12 — E-mail inválido | Aprovado |

**Resultado da última execução:** 2 testes aprovados e 1 teste reprovado devido ao defeito identificado no CT10.

As evidências da execução automatizada estão disponíveis em [`automacao/evidencias`](../../automacao/evidencias/).

## 6. Conclusão

Os testes realizados permitiram validar as principais regras de negócio da Verzel Store e identificar inconsistências relacionadas ao frete grátis e ao limite máximo de quantidade por produto.

Os cenários, resultados e evidências foram organizados para facilitar a rastreabilidade, a reprodução dos defeitos e a análise técnica.

