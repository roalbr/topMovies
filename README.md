# TopFilmes-Teste

Aplicativo para teste de desenvolvimento


## Desafio

O objetivo do teste é fazer uma lista em grid com a imagem e nome dos filmes utilizando a api: https://www.themoviedb.org/documentation/api

## Arquitetura utilizada

MVVM (Movel-View-ViewModel) 


## Dependências externas

#### Alamofire 


## Como compilar

1. Instale o CocoaPods: https://cocoapods.org/
2. No terminal, entre na pasta onde se encontra o arquivo 'Podfile' e digite: `pod install`
3. Abrir o projeto pelo arquivo **`TopFilmes.xcworkspace`**
4. Atualizar a SwiftVersion das dependencias externas(Alamofire, AlamofireObjectMapper, ObjectMapper) para 4.2
5. Command+R paraexecutar o aplicativo e Command+U para executar os testes.

## Features Desenvolvidas

#### Listagem de filmes
Inicia com os filmes mais populares e tem a opção de abrir o filtro ou a tela de favoritos

#### Detalhes
Ao tocar em um filme na lista principal ou nos favoritos, esta tela é aberta e carrega mais dados sobre o filme. É possivel adicionar ou remover o filme aos favoritos

#### Filtro
Busca personalizada pelo titulo desejado e opcionalmente pelo ano do filme.

#### Listagem de Favoritos:
Consulta no CoreData e lista os filmes salvos.

## Desenvolvimento

### Rodrigo Prado de Albuquerque
### ralbuquerque.info@gmail.com


# topMovies

![Image of Query Repositories](topFilmes-lista.png)









