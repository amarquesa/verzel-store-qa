# Relatório de Bugs — Verzel Store

**Data dos testes:** 07/10/2026  
**Ambiente:** https://verzel-store.qa-test-verzel-store.workers.dev/

## BUG-01 — API permite quantidade superior ao limite de 5 unidades

**Cenário relacionado:** CT10  
**Severidade sugerida:** Alta  
**Status:** Aberto — Defeito reproduzido

### Descrição

A interface da Verzel Store limita a quantidade de cada produto a 5 unidades. Entretanto, os endpoints de carrinho e pedidos aceitaram requisições contendo 10 unidades do mesmo produto.

### Pré-condições

- Acesso à Verzel Store.
- Acesso aos endpoints de carrinho e pedidos.

### Passos para reprodução

1. Adicionar 5 unidades de um produto pela interface.
2. Tentar aumentar a quantidade para 6 unidades.
3. Confirmar que a interface apresenta o limite máximo.
4. Enviar uma requisição com quantidade 10 para `/api/carrinho/calcular`.
5. Repetir a validação no endpoint `/api/pedidos`.

### Resultado esperado

A interface e as APIs devem respeitar o limite máximo de 5 unidades por produto.

### Resultado obtido

- Interface: limite de 5 unidades respeitado.
- API `/api/carrinho/calcular`: retornou HTTP 200 aceitando 10 unidades.
- API `/api/pedidos`: retornou HTTP 201 aceitando 10 unidades.

### Evidências

- [Interface — Limite máximo](cenarios-de-teste/evidencias/CA10-%20Limite%20máximo%20interface.png)
- [API do carrinho — HTTP 200](cenarios-de-teste/evidencias/CA10-%20Bug%20limite%20máximo%20carrinho.png)
- [API de pedidos — HTTP 201](cenarios-de-teste/evidencias/CA10-%20BUG%20limite%20máximo%20pedido.png)

### Conclusão

Foi identificada uma divergência entre a validação aplicada na interface e o comportamento das APIs. Recomenda-se validar o limite também no backend.

---

## BUG-02 — Frete grátis não aplicado exatamente em R$ 200,00

**Cenário relacionado:** CT06  
**Critério de aceitação:** CA06  
**Severidade sugerida:** Alta  
**Status:** Aberto — Defeito reproduzido

### Descrição

A regra de negócio estabelece frete grátis para compras com subtotal a partir de R$ 200,00. Entretanto, ao atingir exatamente esse valor, o sistema mantém a cobrança de R$ 19,90 de frete.

### Pré-condições

- Acesso à Verzel Store.
- Carrinho sem cupom aplicado.

### Passos para reprodução

1. Adicionar 4 unidades da Garrafa Térmica 750ml, com preço unitário de R$ 50,00.
2. Acessar o carrinho.
3. Confirmar que o subtotal é R$ 200,00.
4. Verificar o frete e o total do pedido.
5. Como validação complementar, aumentar o subtotal para R$ 250,00.

### Resultado esperado

Para subtotal de R$ 200,00:

- Frete: R$ 0,00.
- Total: R$ 200,00.

### Resultado obtido

Para subtotal de R$ 200,00:

- Frete: R$ 19,90.
- Total: R$ 219,90.
- Mensagem apresentada: "Faltam R$ 0,00 para o frete grátis".

Ao aumentar o subtotal para R$ 250,00, o sistema concedeu corretamente o frete grátis.

### Evidências

- [Subtotal de R$ 200,00 — Falha](cenarios-de-teste/evidencias/CT06-frete-gratis-200.png)
- [Subtotal de R$ 250,00 — Validação complementar](cenarios-de-teste/evidencias/CT06-frete-gratis-250.png)

### Conclusão

O defeito ocorre no valor exato do limite de frete grátis. Uma hipótese técnica a investigar é a utilização de comparação estrita (`> 200`) em vez de inclusiva (`>= 200`).

---

## Resumo dos defeitos

| ID | Cenário | Defeito | Status |
|---|---|---|---|
| BUG-01 | CT10 | API aceita mais de 5 unidades | Aberto |
| BUG-02 | CT06 | Frete grátis não aplicado em R$ 200,00 | Aberto |

Os defeitos foram identificados durante a execução dos testes e estão acompanhados de evidências para reprodução e análise técnica.
