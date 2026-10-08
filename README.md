# Verzel Store — Projeto de QA

## Sobre o projeto

Projeto de Quality Assurance (QA) desenvolvido para avaliar as funcionalidades da Verzel Store, por meio de testes manuais, validações de regras de negócio, testes de API e automação com Playwright.

O objetivo é identificar inconsistências, registrar evidências e documentar os resultados de maneira clara e reproduzível.

## Escopo dos testes

- Aplicação e validação de cupons de desconto.
- Cálculo de subtotal, desconto, frete e total.
- Limite de quantidade de produtos.
- Validação de dados do cliente.
- Regras do processo de compra.
- Validação de respostas das APIs.

## Estrutura do repositório

| Caminho | Descrição |
|---|---|
| `cenarios-de-teste/cenarios.md` | Casos de teste manuais e resultados |
| `cenarios-de-teste/evidencias/` | Evidências dos testes manuais |
| `cenarios.feature` | Cenários descritos em Gherkin |
| `bugs.md` | Registro de defeitos identificados |
| `automacao/loja.spec.js` | Testes automatizados com Playwright |
| `automacao/evidencias/` | Evidências das execuções automatizadas |

## Testes automatizados

Foram implementados três testes de API:

| ID | Cenário | Comportamento esperado |
|---|---|---|
| CT10 | Limite máximo de 5 unidades por produto | Rejeitar quantidade superior ao limite |
| CT11 | Cálculo e arredondamento | Retornar os valores esperados |
| CT12 | Validação de e-mail inválido | Rejeitar dados inválidos |

## Defeito identificado

**BUG-01 — API permite quantidade superior ao limite de 5 unidades.**

Durante os testes, foi identificada uma inconsistência entre a interface e o backend.

A interface impede quantidades superiores a 5 unidades por produto, enquanto as APIs testadas aceitaram requisições contendo 10 unidades.

O CT10 foi configurado para validar a regra esperada. Sua falha na automação evidencia o comportamento divergente da API.

Os detalhes de reprodução e os resultados observados estão documentados em `bugs.md`.

## Como executar os testes

**Pré-requisitos:** Node.js e npm instalados.

No terminal, a partir da raiz do repositório:

```bash
cd automacao
npm install
npx playwright test
```

Para executar somente um cenário:

```bash
npx playwright test --grep "CT10"
```

## Resultados e evidências

A execução inicial registrou três testes aprovados, incluindo uma verificação exploratória que reproduzia o comportamento incorreto do CT10.

Posteriormente, o CT10 foi ajustado para exigir o cumprimento da regra de negócio e passou a falhar, pois a API retorna HTTP 200 para uma quantidade que deveria ser rejeitada.

As evidências das execuções estão disponíveis em `automacao/evidencias/`.

**Uma falha de teste decorrente de defeito identificado não representa falha na execução da atividade de QA:** ela demonstra que a validação detectou uma divergência entre o comportamento esperado e o comportamento observado.

## Tecnologias utilizadas

- JavaScript
- Node.js
- Playwright
- Git e GitHub
- GitHub Codespaces

## Considerações finais

O projeto reúne cenários de teste, evidências, documentação de defeitos e automação, com foco na rastreabilidade dos resultados e na identificação de problemas que possam afetar as regras de negócio da aplicação.

- JavaScript
- Playwright
- Node.js
- GitHub Codespaces
