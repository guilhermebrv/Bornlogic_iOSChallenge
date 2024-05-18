# Bornlogic_iOSChallenge

## Descrição do Projeto
Este repositório contém o código-fonte de um aplicativo desenvolvido como parte do teste técnico para vaga de desenvolvedor iOS na **Bornlogic**. O aplicativo é uma ferramenta de leitura de notícias que permite aos usuários visualizar e interagir com artigos de maneira organizada e intuitiva.

## Funcionalidades do Aplicativo
- **Tela Principal**: Lista notícias em uma UITableView, exibindo imagem, autor, título e descrição breve de cada artigo.
- **Detalhamento de Notícia**: Ao selecionar uma notícia, o usuário é levado a uma nova tela onde pode visualizar em mais detalhes a imagem em tamanho maior, a data de publicação e o conteúdo do artigo.

## Integração com API
Os dados são fornecidos pela **NewsAPI**, acessados através de requisições feitas com **URLSession**, a solução nativa da Apple para operações de rede.

## Tecnologias e Práticas Utilizadas
- **Linguagem**: Swift
- **Framework**: UIKit(ViewCode) para a construção da interface
- **Arquitetura**: MVVM, que promove uma clara separação de responsabilidades dentro do código, facilitando a manutenção e aderindo aos princípios SOLID.
- **Testes Unitários**: Implementados com o auxílio do framework XCTest e test doubles, focando na validação das requisições de rede e lógica de processamento de dados na view model.
