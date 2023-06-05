
# Gestor de Funcionários com Flask

Este repositório contém um aplicativo web desenvolvido com Flask, um micro-framework de Python, que gerencia informações de funcionários em uma empresa. O aplicativo também usa Bootstrap para auxiliar no design da interface do usuário e SQLAlchemy para interagir com o banco de dados MySQL.

## Estrutura do Banco de Dados

O aplicativo usa dois modelos de banco de dados - `Funcionario` e `Setor`. Cada `Funcionario` está associado a um `Setor` por meio da chave estrangeira `setor_id`.

## Rotas

O aplicativo possui várias rotas para realizar diferentes operações:

1.  `/` - A rota raiz que renderiza a página principal do aplicativo.
2.  `/login` - Uma rota POST que lida com o login do usuário.
3.  `/painel` - A rota que renderiza o painel de controle do usuário.
4.  `/insert` - Uma rota POST que lida com a inserção de um novo `Funcionario` no banco de dados.
5.  `/update` - Uma rota POST que lida com a atualização dos detalhes de um `Funcionario` existente.
6.  `/delete/<int:id>` - Uma rota que lida com a exclusão de um `Funcionario` do banco de dados.
7.  `/search` - Uma rota que lida com a pesquisa de um `Funcionario`.
8.  `/funcionarios` - Uma rota que renderiza a página com a lista de todos os `Funcionarios`.
9.  `/gerar_pdf` - Uma rota que gera um PDF contendo a lista de todos os `Funcionarios`.



## Como executar o aplicativo

Para iniciar o aplicativo, você pode copiar e colar o seguinte comando no seu terminal:

pythonCopy code

`python app.py` 

## Observações

Este é um aplicativo simples e não inclui autenticação robusta, nem lidar com erros e exceções de forma abrangente. Para uso em ambiente de produção, esses aspectos precisariam ser considerados e implementados.

## Licença

Este projeto é licenciado sob os termos da Licença MIT.
