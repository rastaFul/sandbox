# Sandbox

Projeto criado para automatizar e gerenciar o ambiente de desenvolvimento/homologação.
Aqui será possível ter acesso a um gerenciador de container com interface gráfica, scripts de deploys dos projetos e todos os serviços que são necessários para a execução desses projetos.
Criamos dois projetos(Conhecido como stack no portainer), com responsabilidades específicas, para fornecer os serviços que serão utilizados pelos projetos e os projetos em si.

## Dependências

Para utilizar o projeto Sandbox é preciso ter o Docker e o Docker composer instalado na máquina que será implantado.
- `Docker` versão 19.03.13 ou superior;
- `Docker-compose` versão 1.27.2 ou superior;

`Acesse a documentação do docker para obter informações sobre a instalação desses serviços no seu ambiente local(Os links com referência para o método de instalação recomendado está no final dessa documentação)`

## Stack Serviços

Aqui está agrupado todos os serviços que são necessários para a execução dos projetos, que são:

- Mongo latest
- Redis latest
- Elastic Search 1.3.9

## Como usar

Para criar os containers com os serviços, basta executar o script:
> bash build.sh $stack-name $container-name

Esse script é o responsável por criar as imagens dos projetos, mas sem executá-los.
Aqui é possivel utilizá-lo para criar as imagens de todos os containers dentro da stack ou de um container específicos, para isto, basta controlar com a informação do segundo parâmetro, que é o nome do container que será criado. Caso não seja informado nenhum nome, é criado todos os containers da stack específicada no primeiro parâmetro(Parâmetro esse obrigatório, e pode ser: `services` ou `projects`).

Para iniciar os containers com os serviços, basta executar o script:
> bash build.sh $stack-name $container-name

Esse script é o responsável por iniciar os containers que foram criados previamente.
Os parâmetros desse script funcionam exatamente da mesma maneira do exemplo anterior

Para parar os serviços, basta executar o comando:
> bash down.sh $stack-name

Seu funcionando é idêntico ao processo de inicialização dos serviços, aceitando um parâmetro para pausar um serviço específico, ou irá pausar todos os serviços caso o parâmetro com o nome do serviço não for executado.

## Script automatizado

Além dos comandos informados acima, é possível utilizar o script da sandbox para clonar os repositórios dos projetos e construir/iniciar os containers com apenas um único comando.

O seu uso é bem simples:

### Clonar os repositórios

Para isso, é necessário que você tenha o `git` instalado na sua máquina e com permissão aos repositórios que serão clonados.
Tendo isso ok, basta apenas executar o seguinte script:
> bash sandbox.sh clone

### Fazer o deploy local das aplicações e serviços

Para isto, é apenas necessário executar o mesmo script informado acima, com os seguintes parâmetros

> bash sandbox.sh deploy {services|projects}

`Opcional: Pode ser informado após o nome da stack, o nome do container específico que deseja fazer o deploy. Caso esse não seja informado, será feito o deploy de todos os containers da stack informada.`


## Informações úteis

- **Não** foi feito um processo automatizado para restaurar backups dos bancos de dados.
Consultar a documentação do banco de dados que deseja realizar a restauração para obter mais informações.
`Verificar com a equipe onde conseguir os backups dos bancos de dados dos principais projetos.`

- Por convenção, o projeto sandbox deve estar localizado no caminho `/home/$USER/projects/`. Isso facilitará as configurações, evitando a necessidade de editar o caminho padrão dos projetos(Está na primeira linha do script sandbox.sh)

- Para executar o nginx, fazendo proxy reverso com os projetos, é necessário adicionar a rede de projetos no arquivo services.yml.
Para isto, basta adicionar na sessão network a seguinte configuração:
```  
projects: 
    external:
        name: projects
```

E adicionar esta rede ao serviço do nginx (Os outros serviços estão utilizando a rede default, basta copiar essa configuração e substituir para o nome da projects)

## FAQ

- Nginx não pode ser executado pois a porta 80 já está em uso: 
Esse problema costuma ocorrer em sistemas Linux que já tem o apache executando por padrão no sistema operacional. Nesse caso, é necessário pausar esse serviço para que o nginx possa escutar as requisições nesta porta. Para isto, execute o comando abaixo:
> sudo /etc/init.d/apache2 stop

- Erro ao executar um dos serviços porque a porta já está em uso:
Isso pode ocorrer em máquinas que já possuem o mesmo serviço instalado diretamente na máquina. Para corrigir o problema, pause o serviço que está em execução ou desinstále-o, caso deseje usar apenas dentro do container.

- Onde são armazenados os arquivos de bancos de dados? 
Por convenção, criamos os volumes dos serviços apontando para o comando `/var/volumes/<nome_serviço>`. Portanto, caso seja necessário visualizar ou fazer o backup dessa informações, basta acessar a pasta do serviço que deseja e salvar os arquivos presentes nesta pasta.

- Como faço para restaurar o banco de dados do mongoDB?
Conforme informado na sessão `Informações Úteis`, esse processo ainda não foi automatizado. Porém para facilitar a restauração, basta inserir o backup do banco de dados no caminho de volumes do serviço mongodb, acessar o container, e executar o comando de restauração conforme a documentação do mongo.

#### Referências

- [Proxy Reverso](./nginx/README.md)
- [Instalação do docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
- [Instalação do docker compose](https://docs.docker.com/compose/install/#install-compose-on-linux-systems)