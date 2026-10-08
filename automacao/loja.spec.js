
const { test, expect } = require('@playwright/test');

test('CT10 - API aceita quantidade superior a 5', async ({ request }) => {
  const resposta = await request.post(
    'https://verzel-store.qa-test-verzel-store.workers.dev/api/carrinho/calcular',
    {
      data: {
        itens: [{ produtoId: 'P001', quantidade: 10 }]
      }
    }
  );

  expect(resposta.status()).toBe(200);
  const dados = await resposta.json();
  expect(dados).toBeDefined();
});

test('CT11 - Validar cálculo e arredondamento', async ({ request }) => {
  const resposta = await request.post(
    'https://verzel-store.qa-test-verzel-store.workers.dev/api/carrinho/calcular',
    {
      data: {
        itens: [{ produtoId: 'P001', quantidade: 3 }],
        cupom: 'BEMVINDO10'
      }
    }
  );

  expect(resposta.status()).toBe(200);

  const dados = await resposta.json();

  expect(dados.subtotal).toBeCloseTo(179.70, 2);
  expect(dados.desconto).toBeCloseTo(17.97, 2);
  expect(dados.frete).toBeCloseTo(19.90, 2);
});


test('CT12 - Validar email invalido na API', async ({ request }) => {
  const resposta = await request.post(
    'https://verzel-store.qa-test-verzel-store.workers.dev/api/pedidos',
    {
      data: {
        cliente: {
          nome: 'Amanda Silva',
          email: '@gmail.com',
          cep: '70000000'
        },
        itens: [{ produtoId: 'P001', quantidade: 1 }]
      }
    }
  );

  // A API deve rejeitar um e-mail inválido.
  expect([400, 422]).toContain(resposta.status());
});
