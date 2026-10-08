# BUG-01 — API permite quantidade superior ao limite de 5 unidades

**Cenário relacionado:** CT10

**Descrição:** A interface da Verzel Store limita a quantidade de cada produto a 5 unidades. Entretanto, durante os testes, as APIs aceitaram requisições com 10 unidades.

**Pré-condições:**
- Acesso à Verzel Store.
- Acesso aos endpoints de carrinho e pedidos.

**Passos para reprodução:**
1. Adicionar 5 unidades de um produto pela interface.
2. Tentar adicionar uma sexta unidade.
3. Verificar a mensagem de limite.
4. Enviar uma requisição com quantidade 10 para `/api/carrinho/calcular`.
5. Repetir o teste em `/api/pedidos`.

**Resultado esperado:** As APIs devem aplicar o mesmo limite de 5 unidades por produto estabelecido pela interface.

**Resultado obtido:** A interface bloqueou a quantidade superior a 5, porém as APIs aceitaram 10 unidades, retornando HTTP 200 e HTTP 201, respectivamente.

**Status:** BUG IDENTIFICADO — possível ausência de validação no backend.

**Evidências:**
- `CT10-limite-5-unidades-interface.png`
- `CT10-bug-limite-api-carrinho.png`
- `CT10-bug-limite-api-pedidos.png`
