# emi-learning-task-12.2
Explorando o Mundo iOS - Learning Task 12.2

## Completando o trabalho para ter o fluxo de livros integrado com a API

Através deste repositório base, complete o trabalho iniciado pelo especialista para chegar ao objetivo do desafio. O objetivo da tarefa é ter uma aplicação que execute o fluxo de navegação de livros da app da editora, apresentando (enviando) os dados da (para) Casa do Código API (disponível em https://casadocodigo-api.herokuapp.com/api) e atendendo às especificações de design disponíveis abaixo.

Os endpoints que deverão ser consumidos na atividade são: (i) https://casadocodigo-api.herokuapp.com/api/book que retorna uma lista com todos os livros através de um _GET Request_; e (ii) https://casadocodigo-api.herokuapp.com/api/book _POST Request_ através do qual você pode enviar os dados de um livro para a API, recebendo de volta o dado atualizado do novo livro criado. Já existe uma implementação no projeto base para o consumo da lista de autores, embora ainda caiba aplicação das técnicas desta seção em seu código. Já existe também um controlador que pode ser usado para selecionar um autor na lista de autores da API, no fluxo de criação de um novo livro. Seu principal desafio será o consumo da lista de livros, além da criação de novos.

* Abaixo você confere a imagem que ilustra o fluxo de navegação esperado ao fim desta tarefa:

    ![Imagem com a especificação alvo para o desafio, com o fluxo de navegação da tab de livros, além da especificação de design dos novos elementos](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt2-especificacao-alvo.jpg?raw=true)

* A seguir você também tem a imagem com as propriedades de design dos componentes das telas.

    ![Imagem com a especificação de tela _](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt2-especificacao-de-design.jpg?raw=true)
    
> Nota: A Casa do Código não tem uma API pública. Todo o trabalho se dá pelo consumo de uma API construída internamente para simular o contexto da editora. Nem todos os dados podem ser verídicos. Por razões de infraestrutura, é esperado que alguns requests tenham seu tempo de resposta aumentado, já que algumas vezes o serviço precisará ser inicializado devido a indisponibilidade por tempo de inatividade. Os recursos também são limitados, então, faça um uso consciente durante sua atividade para evitar indisponilibidade prolongada. Você pode consultar a documentação da API através do link https://casadocodigo-api.herokuapp.com/swagger-ui/index.html, ou mesmo o projeto da API desenvolvido em Java em https://github.com/rafael-rollo/casadocodigo-api. Rodar o projeto localmente também pode ser uma boa opção em tempo de desenvolvimento. ✌🏻
