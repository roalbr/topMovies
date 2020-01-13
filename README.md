# TopFilmes-Teste

Aplicativo que lista os principais filmes do "The Movie".


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
#### Listagem de filmes
![topFilmes-lista](https://user-images.githubusercontent.com/17296448/72229279-1dceb100-358c-11ea-9399-e111e8623c0c.png)

#### Detalhe de filmes
![topFilmes-Detalhe](https://user-images.githubusercontent.com/17296448/72229332-99306280-358c-11ea-85fc-7bfcd82831b4.png)

#### Favoritos
![topFilmes-Favorito](https://user-images.githubusercontent.com/17296448/72229333-99306280-358c-11ea-9009-d8c010bda8df.png)

#### Filtro
![topFilmes-filtro](https://user-images.githubusercontent.com/17296448/72229334-99306280-358c-11ea-8f0b-7ff551b77f39.png)

#### Resultado do Filtro
![topFilmes-resultadoFiltro](https://user-images.githubusercontent.com/17296448/72229335-99306280-358c-11ea-88fe-54aa591c31b0.png)

#### Resultado sem Filtro
![topFilmes-semResultadoFiltro](https://user-images.githubusercontent.com/17296448/72229336-99306280-358c-11ea-8494-55e1caf93c21.png)

#### Regra de negócio de filtro
![topFilmes-alert](https://user-images.githubusercontent.com/17296448/72229331-9897cc00-358c-11ea-9f9e-98321e4cf5ba.png)
![topFilmes-filtro](https://user-images.githubusercontent.com/17296448/72229334-99306280-358c-11ea-8f0b-7ff551b77f39io .png)












