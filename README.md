# Web Crawler de Frases - Ruby on Rails

Este projeto consiste em um web crawler em Ruby on Rails para buscar frases no site http://quotes.toscrape.com/. A aplicação disponibiliza os resultados via API, com destaque para as seguintes funcionalidades:

* ### Busca por Tag:

  * Recebe uma tag como parâmetro e retorna frases categorizadas de acordo.

* ### Armazenamento no MongoDB:

  * Salva as frases e tags associadas no MongoDB.

* ### Consulta de Cache Eficiente e job automatizado:

  * Evita consultas repetidas; retorna dados persistidos e verifica a cada 12 horas o site de origem com as tags já armazenadas para atualizar novas citações que possam ter sido criadas com as mesmas.

* ### Token de Acesso com Expiração:

  * Implementação de geração de token de acesso que expira em 10 minutos para garantir segurança na API.
