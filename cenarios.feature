
Feature: Carrinho de compras - Cupons e frete
  Como cliente da loja
  Quero aplicar cupons e calcular o frete
  Para finalizar minhas compras com os valores corretos

  Background:
    Given que o cliente possui produtos no carrinho

  @CT01 @CA01
  Scenario: Aplicar cupom BEMVINDO10
    Given que o subtotal dos produtos é R$ 100,00
    When o cliente aplicar o cupom "BEMVINDO10"
    Then o desconto deverá ser de R$ 10,00
    And o subtotal com desconto deverá ser R$ 90,00

  @CT02 @CA02
  Scenario Outline: Validar letras e espaços no cupom
    Given que o subtotal dos produtos é R$ 100,00
    When o cliente aplicar o cupom "<cupom>"
    Then o cupom deverá ser aceito
    And o desconto deverá ser de R$ 10,00

    Examples:
      | cupom          |
      | bemvindo10     |
      | BEMVINDO10     |
      | BeMvInDo10     |
      |  BEMVINDO10    |
      | BEMVINDO10     |

  @CT03 @CA03
  Scenario: Aplicar cupom inexistente
    Given que o subtotal dos produtos é R$ 100,00
    When o cliente aplicar o cupom "INVALIDO123"
    Then deverá aparecer a mensagem "Cupom inválido."
    And nenhum desconto deverá ser aplicado

  @CT04 @CA04
  Scenario: Aplicar cupom expirado
    Given que existe um cupom com validade encerrada
    When o cliente aplicar o cupom expirado
    Then deverá aparecer a mensagem "Cupom expirado."
    And nenhum desconto deverá ser aplicado

  @CT05 @CA05
  Scenario: Substituir um cupom aplicado
    Given que o cliente possui um cupom aplicado
    When o cliente tentar aplicar outro cupom
    Then não deverá ser permitido acumular cupons
    When o cliente remover o cupom atual
    And aplicar outro cupom válido
    Then somente o novo cupom deverá permanecer aplicado

  @CT06 @CA06
  Scenario Outline: Validar limite do frete grátis
    Given que o subtotal dos produtos é <subtotal>
    When o carrinho calcular o frete
    Then o valor do frete deverá ser <frete>

    Examples:
      | subtotal  | frete   |
      | R$ 200,00 | R$ 0,00 |
      | R$ 250,00 | R$ 0,00 |

  @CT07 @CA07
  Scenario Outline: Validar frete abaixo de R$ 200,00
    Given que o subtotal dos produtos é <subtotal>
    When o carrinho calcular o frete
    Then o frete deverá ser R$ 19,90
    And deverá informar que faltam <restante> para o frete grátis

    Examples:
      | subtotal  | restante  |
      | R$ 100,00 | R$ 100,00 |
      | R$ 199,99 | R$ 0,01   |

  @CT08 @CA08
  Scenario: Calcular frete antes do desconto
    Given que o subtotal dos produtos é R$ 200,00
    When o cliente aplicar o cupom "BEMVINDO10"
    Then o desconto deverá ser R$ 20,00
    And o frete deverá continuar gratuito
    And o total do pedido deverá ser R$ 180,00

  @CT09 @CA09
  Scenario: Não aplicar desconto sobre o frete
    Given que o subtotal dos produtos é R$ 100,00
    And o frete é R$ 19,90
    When o cliente aplicar o cupom "BEMVINDO10"
    Then o desconto deverá ser R$ 10,00
    And o frete deverá permanecer R$ 19,90
    And o total do pedido deverá ser R$ 109,90

  @CT10 @CA10
  Scenario Outline: Validar limite de unidades por produto
    Given que o produto está disponível para compra
    When o cliente solicitar <quantidade> unidades via <origem>
    Then o sistema deverá apresentar o resultado "<resultado>"

    Examples:
      | quantidade | origem    | resultado |
      | 5          | Interface | Permitido |
      | 6          | Interface | Bloqueado |
      | 5          | API       | Permitido |
      | 6          | API       | Bloqueado |

  @CT11 @CA11
  Scenario Outline: Validar arredondamento monetário
    Given que existe um cálculo com resultado <valor>
    When o sistema apresentar o valor monetário
    Then deverá exibir <esperado> com duas casas decimais

    Examples:
      | valor  | esperado |
      | 10,555 | 10,56    |
      | 10,554 | 10,55    |
      | 19,9   | 19,90    |
      | 100    | 100,00   |
