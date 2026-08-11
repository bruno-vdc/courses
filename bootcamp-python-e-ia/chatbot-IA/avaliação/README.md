# Avaliando o Chatbot com um Exemplo

  Foram feitas perguntas ao Assistente Financeiro para atestar seu funcionamento. Abaixo serão mostrados prints das perguntas, das respostas e a intenção de cada uma será explicada

## **Pergunta 1 e 2**

<p align="center">
  <img src="../imagens/perguntas_1_2.png" width="700">
</p>

  Uma saudação simples foi feita e, em seguida, o modelo foi questionado sobre quais os produtos disponíveis para investir. Os dados dos produtos, inicialmente passados como JSON, foram convertidos em uma tabela com suas informações principais, mantendo a resposta simples e curta, mas completa para entendimento.

## **Pergunta 3**

<p align="center">
  <img src="../imagens/pergunta_3.png" width="700">
</p>

  Propositalmente, produtos não listados foram mencionados como sendo a intenção do usuário. A resposta, como esperado, deixava claro que não estão disponíveis e sugeriu ajuda para algo do catálogo atual, mostrando a correta interpretação dos dados de entrada e a não invenção de informações.

## **Pergunta 4**

<p align="center">
  <img src="../imagens/pergunta_4.png" width="700">
</p>

  Dessa vez, foi pedido uma sugestão para o assistente, que recomendou os produtos de melhor rendimento para risco baixo, mostrando ter compreendido o perfil moderado do cliente.
  De brinde, ainda descartou quais aplicações devem ser evitadas por conta do risco envolvido.

## **Pergunta 5**

<p align="center">
  <img src="../imagens/pergunta_5.png" width="700">
</p>

  Por fim, o modelo foi questionado do porquê de um produto não ter sido recomendado. Novamente, os dados do cliente foram usados para explicar que o produto em questão é incompatível com o perfil e necessidade atual do cliente.

## **Conclusão**

  Essas perguntas conseguiram atestar o que mais era esperado do Assistente Financeiro:
  - Os dados de entrada foram corretamente interpretados;
  - As respostas foram simples, mas capazes de sanar dúvidas;
  - Embora amplamente conhecidos, o chatbot não inventou informações sobre os investimentos que ele desconhecia, deixando claro que não sabia sobre o assunto;
  - Foi capaz de responder dúvidas sobre os produtos e sugerir o que é adequado para o cliente.
