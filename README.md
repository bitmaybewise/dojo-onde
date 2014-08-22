#Dojo, onde?

[![Code Climate](https://codeclimate.com/github/hlmerscher/dojo-onde.png)](https://codeclimate.com/github/hlmerscher/dojo-onde) [![Build Status](https://travis-ci.org/hlmerscher/dojo-onde.png)](https://travis-ci.org/hlmerscher/dojo-onde) [![Coverage Status](https://coveralls.io/repos/hlmerscher/dojo-onde/badge.png)](https://coveralls.io/r/hlmerscher/dojo-onde)

Site com o intuito de ajudar a disseminar coding dojos. Nele podemos registrar nossos coding dojos informando data, hora, local e espalhar para amigos e interessados participarem.

Acesse: <http://www.dojoonde.com.br>

## Executando o projeto

Execute o bundler para baixar todas as dependências do projeto.
	
    $ bundle install

Copie o arquivo de exemplo de configuração de acesso ao banco de dados e configure como desejar. 

    $ cp config/database.example config/database.yml
    $ rake db:create db:migrate

Para utilizar o recurso de login com redes sociais defina as seguintes variáveis de ambiente com suas respectivas chaves.

    TWITTER_KEY
    TWITTER_SECRET
    GITHUB_KEY
    GITHUB_SECRET
    FACEBOOK_KEY
    FACEBOOK_SECRET

Depois destes passos é só executar.

    $ rails s

### Em produção

Antes de expor ao público devemos gerar um novo token de segurança. 

    $ rake secret

Ao executar o comando acima exibirá no console uma nova chave de segurança. Defina a variável de ambiente SECRET_TOKEN.

    $ export SECRET_TOKEN="chave_gerada_aqui"

Para usar com Heroku basta executar o seguinte.

    $ heroku config:set SECRET_TOKEN="chave_gerada_aqui"

## Funcionalidades novas, bug's, etc.

Achou um bug, tem ideia de uma funcionalidade super bacana que gostaria de ver no site ou simplesmente quer acompanhar e comentar a respeito?
Visite nossa [issue list](https://github.com/hlmerscher/dojo-onde/issues?state=open).

## Criador e mantenedor

Hercules Lemke Merscher, [hlmerscher](https://github.com/hlmerscher/)

## Contribuidores

João Víctor Rocon Maia, [jvrmaia](https://github.com/jvrmaia)
