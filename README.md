#Dojo, onde?

[![Code Climate](https://codeclimate.com/github/hlmerscher/dojo-onde.png)](https://codeclimate.com/github/hlmerscher/dojo-onde)

Site com o intuito de ajudar a disseminar coding dojos. Nele podemos registrar nossos coding dojos informando data, hora, local e espalhar para amigos e interessados participarem.

Acesse: <http://dojoonde.herculesdev.com.br>

## Executando o projeto

Execute o bundler para baixar todas as dependências do projeto.
	
	$ bundle install

Copie o arquivo de exemplo de configuração de acesso ao banco de dados e configure como desejar. 

    $ cp config/database.example config/database.yml
	$ rake db:create db:migrate

Copie também o token de segurança a partir do arquivo de exemplo.

	$ cp config/initializers/secret_token.example config/initializers/secret_token.rb

Depois destes passos é só executar o servidor.

	$ rails s

### Em produção

Antes de expor ao público devemos gerar um novo token de segurança. 

	$ rake secret

Ao executar o comando acima imprimirá no console uma nova chave de segurança. Substitua a chave que se encontra no arquivo secret_token.rb pela nova.

## Funcionalidades novas, bug's, etc.

Acho um bug, tem ideia de uma funcionalidade super bacana que gostaria de ver no site ou simplesmente quer acompanhar e comentar a respeito?
Visite nossa [issue list](https://github.com/hlmerscher/dojo-onde/issues?state=open).

## Criador e mantenedor

Hercules Lemke Merscher, [hlmerscher](https://github.com/hlmerscher/)

## Contribuidores

João Vítor Rocon Maia, [jvrmaia](https://github.com/jvrmaia)
