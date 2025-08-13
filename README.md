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

## Instruções de execução
Primeiro de tudo, a máquina deve ter o `cocoapods` instalado
- brew install cocoapods

com o cocoa instalado, na pasta raíz do projeto executar
- `pod install`

depois disso, abrir o arquivo `PopRepoLuiza.xcworkspace`

executar o aplicativo com `cmd + r`
executar os testes com `cmd + u`





