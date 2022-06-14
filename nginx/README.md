# Nginx Proxy reverso

Bem vindo a documentação do container de proxy reverso com nginx.
Aqui você encontrará informações úteis sobre configuração e adição de novos projetos no proxy reverso de sua máquina local ou ambiente de staging.

### Criação de um certificado SSL

Para acessar uma página https de forma segura, é necessário ter um certificado SSL configurado no servidor.
Esse processo não é feito de forma automatizada pelo projeto sandbox, porém é possível criar um certificado para usar no server local apenas seguindo os passos abaixo: 

Acessar a pasta ssl do nginx na sandbox:

> cd nginx/ssl

Executar o comando para geração dos certificados para os containers que precisar criar:
`Substituir o {{nome-container}} pelo nome do container que receberá o certificado`.

> openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout {{nome-container}}.key -out {{nome-container}}.crt

Pronto, o seu certificado estará criado e pronto para ser importado pelo container do proxy reverso.

### Configurando o DNS para acessar os projetos locais através de URL amigágel

Para acessar os projetos sem precisar adicionar as portas que cada um deles está ouvindo, mas acessá-los através de um URL pré definida, deverá ser adicionado a entrada de cada URL apontando para localhost no arquivos de hosts do seu sistema operacional.
`Atualmente as configurações do nginx já prevê as urls de acesso para os containers, portanto é obrigatorio adicionar essas URLS no vhosts para funcionar`.

#### Linux

Acessar o arquivo de hosts do sistema operacional:
> vi /etc/hosts

Adicionar as entradas de configurações necessárias:

> 127.0.0.1   project-php.local <br>
127.0.0.1   project-node.local

### Referências

- [Proxy Reverso com nginx e docker compose](https://dev.to/sukhbirsekhon/what-is-docker-reverse-proxy-45mm)

