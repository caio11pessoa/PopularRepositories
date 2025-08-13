# PopRepoLuiza
App Que mostra todos os repositórios de `swift` ordenado por popularidade com scroll infinito, 
quando clicado mostra todos os pullrequests daquele repositório e se clicado no pull request abre uma `webview` com acesso à página do PullRequest.

------

## Tecnologias utilizadas
- RxSwift + RxCocoa ( Para programação reativa )
- Quick, Nimble ( Para Testes )
- CocoaPods ( Para a gerência de dependências )
- UIKit ( Para a Interface)
- URLSession ( Para chamadas HTTP )

## Arquitetura
Utilizei MVVM
```
📦 PopRepoLuiza
├── 📂 Modules
│   ├── 📂 Network
│   │
│   ├── 📂 Components
│   │
│   └── 📂 Features
│       ├── 📂 PullRequestWebView
│       │
│       ├── 📂 ListPullRequest
│       │
│       └── 📂 ListRepositories
│
├── 📂 Core
    ├── 📂 Models
    │
    └── 📂 Extensions

```

## Escolhas Feitas
Tendo em vista o que é utilizado no superApp, utilizei o RxSwift + RxCocoa para fazer a parte reativa do projeto, na parte da requisição
os métodos da APIClient retorna um fluxo reativo `Observable<[PullRequest]`, possibilitando controlar a assincronicidade da requisição à API e permitindo
que outros se inscerevam para reagir às suas mudanças.

Criei algumas classes que contêm métodos e atributos padrõe para melhorar o reúso, como `AbstractViewModel`, que possui atributos do tipo `BehaviorRelay`,
utilizei o BehaviorRelay para expor dados observáveis para a UI e, por se tratar de um fluxo reativo, sua utilização foi interessante. 
Também criei métodos padrõe que fazem o setup de bindings entre atributos e partes da UI, os quais estarão disponíveis para todas as telas que herdarem dessa classe.

Separei as pastas em módulos - `ListRepositories`, `ListPullRequest`, `PullRequestWebView`, `Components` e `Network` - para facilitar a organização do projeto.
Cada módulo que representa uma feature, como `ListRepositories`, `ListPullRequest` e `PullRequestWebView`, contém sua própria `View` e `ViewModel`.

Sabendo que a stack oficial do SuperApp utiliza `Quick` e `Nimble` para testes, adotei essas tecnologias na realização dos testes unitários.
Criei um mock da `UITableView` para possibilitar a execução e validação de cenários específicos durante os testes.

## Instruções de execução
Primeiro de tudo, a máquina deve ter o `cocoapods` instalado
- `brew install cocoapods`

com o cocoa instalado, na pasta raíz do projeto executar
- `pod install`

depois disso, abrir o arquivo `PopRepoLuiza.xcworkspace`

executar o aplicativo com `cmd + r`
executar os testes com `cmd + u`





