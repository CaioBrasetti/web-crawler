# README

# Web Crawler de Frases - Ruby on Rails

![Ruby Version](https://img.shields.io/badge/Ruby-3.2.2-red.svg)
![Rails Version](https://img.shields.io/badge/Rails-7.1.3.2-orange.svg)

Este projeto consiste em um web crawler em Ruby on Rails para buscar frases no site http://quotes.toscrape.com/. A aplicação disponibiliza os resultados via API.

## Funcionalidades

* ### Busca por Tag:

  * Recebe uma tag como parâmetro e retorna frases de acordo com os resultados obtidos pela mesma.

* ### Armazenamento no MongoDB:

  * Salva as frases, o autor e tag associadas no MongoDB.

* ### Consulta de Cache Eficiente e job automatizado:

  * Evita consultas repetidas; retorna dados persistidos e verifica a cada 12 horas o site de origem com as tags já armazenadas para atualizar novas citações que possam ter sido criadas com as mesmas.

* ### Token de Acesso com Expiração:

  * Implementação de geração de token de acesso que expira em 10 minutos para garantir segurança na API.
 
## Requisitos

Certifique-se de ter as seguintes dependências instaladas:

- Ruby 3.2.2;
- Ruby on Rails 7.1.3.2;
- Postman Desktop (somente para teste).

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

3. Inicie o servidor Rails:

```bash
rails server
```

## Uso

Após seguir os passos de instalação, abra o aplicativo do postman para desktop.
Para maior facilidade, vou deixar aqui um link com a colection contendo a geração do token e a consulta por tag.

Baixe aqui a [colection para teste](https://drive.google.com/file/d/1J93buG0fa36PN7JnMjhzK_GcuQFjJu51/view?usp=drive_link).

1. Após a instalação do postman importe a colection disponibilizada acima;
2. Entre na requisição "criar token";
   - Esta será responsavel por gerar um token que será usado na consulta por tags.
   - Este token tem validade de 10 MINUTOS. Após esse tempo, basta gerar outro token.
3. Copie o token gerado no passo anterior;
4. Entre na requisição "buscar por tag";
   - Adicione o token copiado previamente em **Headers** adicionando os seguintes valores:
       - Em key passe "token";
       - Em "Value" passe o token gerado.
   -  Adicione em **Params** os seguintes valores:
       - Em key passe "tag";
       - Em "Value" passe a tag que deseja. EX: "life".
5. Clique em Send;
6. Observe o resultado encontrado. Caso deseje uma melhor visualização, clique em **Pretty**.

OBS: Caso não deseje ultilizar o postman, basta usar as urls criadas no projeto no local de sua preferencia:
Criar o token: ``` localhost:3000/create_token ```
Encontrar a tag: ``` localhost:3000/scrape_quotes_with_tag?tag=SUA_TAG_AQUI ```

## Resultados

Varios resultados podem ser obtidos dessas consultas. Seguem os mapeados:
**Geração do token:**
- ``` Status: 201, Resposta: Token gerado ```

**Busca por tag**
- ```Status: 200, Resposta: Citações encontradas por aquela tag ```
- ```Status: 400, Mensagem de erro: Ocorreu um erro com o token informado. Por favor tente novamente.```
- ```Status: 404, Mensagem de erro: Por favor forneça um token```
- ```Status: 404, Mensagem de erro: Nenhuma citação encontrada com a tag informada. Tente novamente com outra tag. ```
- ```Status: 422, Mensagem de erro: Por favor, forneça a tag desejada. ```

