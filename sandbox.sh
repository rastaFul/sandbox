echo $1 $2 $3

case "$1" in
    clone)
        echo "Clonando os projetos"
        cd $APPS_DIR
        echo "Clonando projetos..."
        # Descomentar a linha abaixo para clonar projetos
        # git clone <adicionar o repositório>
        echo "Projeto baixado"
        echo "Concluído"
        exit 0;
    ;;    
    deploy)
         if [ -z "$2" ]; then
            echo "ERRO: Para fazer o deploy das aplicações, é necessário informar o nome da stack: sandbox.sh deploy {services|projects}";
            exit 1;
        elif [ "$2" != services -a "$2" != projects ]; then
            echo "ERRO: Para fazer o deploy das aplicações, é necessário informar um nome válido para stack: sandbox.sh deploy {services|projects}";
            exit 1;
        else
            docker-compose -f $2.yml -p $2 build $3
            docker-compose -f $2.yml -p $2 up -d $3
        fi
        exit 0;
    ;;
    *)
        echo "ERRO: Use: sandbox.sh {clone|deploy}" >&2
        exit 1
    ;;
esac    
