# Desafio Final - Bootcamp UseMobile iOS
Desafio final do Bootcamp iOS da Use Mobile. Aplicativo de 4 telas responsável por fazer requisições e popular uma API de animais.

https://user-images.githubusercontent.com/91852898/175352306-74600ba8-5b0e-4354-98e3-597566b5252a.MP4

## Como rodar

- Acessar o XCode através do arquivo AnimalsApp.xcworkspace
- Deployment Target iOS 13.0

## Principais Tecnologias
- Swift e UIKit
- <b>Arquitetura MVVM</b>
- <b>Testes unitários</b>
- Gerenciador de dependências Cocoapods
- Alamofire para requisições API, Lottie para fazer animações e SDWebImage para baixar imagens de forma assíncrona e cache em memória.

## Sobre o aplicativo

O aplicativo possui 3 telas principais: Home, Cadastrar e Favoritos, e 1 tela de detalhes, a qual pode ser acessada clicando em qualquer animal.

- Na tela de Home, listamos os animais cadastrados na API em uma table view. Além disso, usamos SDWebImage para carregar as imagens das células de forma assíncrona e cacheada.

- Na tela de Cadastro, há uma scroll view que se ajusta ao tamanho do teclado de forma automática. Também adicionamos a funcionalidade de mudar o campo do formulário por meio do “seguinte” no teclado, além disso, ao clicar fora dos campos de texto, o teclado desaparece.

- Na tela de Favoritos, são exibidos os animais favoritados, que são persistidos por meio do Core Data. Fizemos a classe do Core Data como um singleton, para que fosse instanciado apenas uma vez e utilizado pela Home e pela tela de Favoritos.

- Como era possível favoritar de ambas as telas, utilizamos um delegate dentro da classe do Core Data para notificar ambas as ViewModels de que houve uma alteração, e a “estrelinha” de favoritos deveria ser atualizada.

- As requisições da API (GET e POST) foram realizadas utilizando Alamofire. E para conformar nosso Model com o JSON, utilizamos Coding Keys.

- Por fim, realizamos testes unitários e, para que isso fosse possível, fizemos mocks do serviço e do Core Data.



