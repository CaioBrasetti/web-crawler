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

## Solução adotada
**Token**
- Utilizei a gem JWT para fazer a criação de tokens;
- Setei um timer para expirar a cada 10 minutos para maior segurança do projeto;
- Exibo o token e o status de que ele foi criado corretamente.

**CrawlersController**
- Esta herda da controller que gerencia o token, para antes de fazer a busca pela tag, verificar se o token é valido.
Aqui dividi a logica em 3 metodos, sendo eles:
- ```scrape_quotes_with_tag```
- Verifico se foi passada uma tag;
- Caso sim:
   - Verifico se já possuo citações daquela tag no banco de dados;
      - Se existir, formato o resultado no experado e retorno ao usuario;
   - Se não existir:
      - chamo os metodos que explicarei abaixo;
      - formato o resultado no experado e retorno ao usuario.
- Caso não: exibo um status de erro e uma mensagem ao usuario.
- OBS: Caso não exista uma citação com aquela tag exibo um status de erro e uma mensagem ao usuario.

- ```scrape_quotes_in_website```
- Inicio variaveis com valores que precisarei usar posteriormente;
- Utilizo a gem Nokogiri para leitura do site;
- Separo somente as informações que serão utilizadas no futuro;
- Armazeno esses valores em um array de hashs;
- Retorno esse array.

- ```search_tag_into_database```
- Recebo uma tag(enviada pelo usuario) que veio do metodo ```scrape_quotes_with_tag```;
- Chamo o metodo ```scrape_quotes_in_website```;
- A partir das informações obtidas no site, verifico de uma a uma se alguma possui a tag que foi informada;
- Caso sim:
   - Armazeno o resultado em um array de hashs;
   - Utilizo um find or create by para somente criar se aquela citação se ainda não existir no banco de dados.
- Caso não: Significa que não existe nenhuma citação com essa tag informada. Então o metodo que chama este irá tratar o erro.

**CRON**
- A cada 12 horas é chamado o job que irá verificar todas as tags inseridas pelos usuarios existentes no banco de dados;
- Passo ao metodo ```search_tag_into_database``` essas tags para que o fluxo explicado acima aconteça.

  
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
- Exemplo de resultado: ```eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3MDk2ODQxODR9.XCaFDtNhjeMadMLZyaxRGypfW69W1R1ndEAmUd-cTMY```

**Busca por tag**
- ```Status: 200, Resposta: Citações encontradas por aquela tag ```
- ```Status: 400, Mensagem de erro: Ocorreu um erro com o token informado. Por favor tente novamente.```
- ```Status: 404, Mensagem de erro: Por favor forneça um token```
- ```Status: 404, Mensagem de erro: Nenhuma citação encontrada com a tag informada. Tente novamente com outra tag. ```
- ```Status: 422, Mensagem de erro: Por favor, forneça a tag desejada. ```
- Exemplo de resultado positivo: 
```bash
{
    "quotes": [
        {
            "quote": "“There are only two ways to live your life. One is as though nothing is a miracle. The other is as though everything is a miracle.”",
            "author": "Albert Einstein",
            "author_about": "https://quotes.toscrape.com/author/Albert-Einstein",
            "tags": [
               "inspirational",
                "life",
                "live",
                "miracle",
                "miracles"
            ]
        }
    ]
}
```
