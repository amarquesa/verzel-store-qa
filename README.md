# Verzel Store — Projeto de QA

Projeto de testes de qualidade de software da Verzel Store, incluindo testes manuais, exploratórios e automatizados com Playwright.

## Entregas

- `cenarios-de-teste/cenarios.md` — Casos de teste e resultados.
- `cenarios-de-teste/evidencias/` — Evidências dos testes manuais.
- `cenarios.feature` — Cenários escritos em Gherkin.
- `bugs.md` — Relatório de defeitos identificados.
- `automacao/loja.spec.js` — Testes automatizados.
- `automacao/evidencias/` — Evidências da execução automatizada.

## Executar os testes automatizados

É necessário ter Node.js e npm instalados.

No terminal, execute:

```bash
cd automacao
npm install
npx playwright test
```

## Resultado da execução

Foram executados 3 testes automatizados, com 3 aprovações na execução registrada.

**Observação:** o teste CT10 reproduz a aceitação de quantidade superior a 5 unidades pela API, comportamento registrado como possível defeito. O resultado positivo da automação não significa que essa regra de negócio esteja correta.

A evidência está disponível em:

`automacao/evidencias/execucao-playwright-3-testes.png`

## Tecnologias

- JavaScript
- Playwright
- Node.js
- GitHub Codespaces