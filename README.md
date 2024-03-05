# README

# Web Crawler de Frases - Ruby on Rails

![Ruby Version](https://img.shields.io/badge/Ruby-3.2.2-red.svg)
![Rails Version](https://img.shields.io/badge/Rails-7.1.3.2-orange.svg)

Este projeto consiste em um web crawler em Ruby on Rails para buscar frases no site http://quotes.toscrape.com/. A aplicação disponibiliza os resultados via AP.

## Funcionalidades

* ### Busca por Tag:

  * Recebe uma tag como parâmetro e retorna frases categorizadas de acordo.

* ### Armazenamento no MongoDB:

  * Salva as frases e tags associadas no MongoDB.

* ### Consulta de Cache Eficiente e job automatizado:

  * Evita consultas repetidas; retorna dados persistidos e verifica a cada 12 horas o site de origem com as tags já armazenadas para atualizar novas citações que possam ter sido criadas com as mesmas.

* ### Token de Acesso com Expiração:

  * Implementação de geração de token de acesso que expira em 10 minutos para garantir segurança na API.
 
## Requisitos

Certifique-se de ter as seguintes dependências instaladas:

- Ruby 3.2.2
- Ruby on Rails 7.1.3.2
- Banco de dados MongoDB
- Postman Desktop

## Instalação

1. Clone este repositório para o seu ambiente local:

```bash
git clone git@github.com:CaioBrasetti/web-crawler.git
cd web-crawler
```

2. Instale as gemas necessárias:

```bash
bundle install
```

3. Configure o banco de dados no arquivo `config/database.yml`.

4. Execute as migrações do banco de dados:

```bash
rails db:migrate
```
