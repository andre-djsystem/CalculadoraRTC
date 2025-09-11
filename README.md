# CalculadoraRTC
Projeto para permitir o uso da Calculadora da Reforma Tributária

## ⭕ Pré-requisitos
- [**RESTRequest4Delphi
**](https://github.com/viniciussanchez/RESTRequest4Delphi/) - Biblioteca que permite consumir serviços REST.

## ⚙️ Instalaçao
A instalação pode ser realizada com o comando [`boss install`](https://github.com/HashLoad/boss)

``` sh
boss install https://github.com/andre-djsystem/CalculadoraRTC
```

### Instalação Manual
Caso queira instalar manualmente, adicione os paths abaixo nas configurações do projeto, em *Project > Project Options > Paths > Other unit files (-Fu) > Include file search path*
```
../CalculadoraRTC/src/client
../CalculadoraRTC/src/config
../CalculadoraRTC/src/core
../CalculadoraRTC/src/schemas
../CalculadoraRTC/src/utils
../restrequest4delphi/src
```

## Como testar
Instale localmente a versão offline da Calculadora da Reforma Tributária disponibilizada pela Receita Federal - https://piloto-cbs.tributos.gov.br/servico/calculadora-consumo/calculadora/calculadora-offline

## ⚠️ Licença
`CalculadoraRTC` é uma biblioteca gratuita e open-source licenciada pela [MIT License](https://github.com/andre-djsystem/CalculadoraRTC/blob/main/LICENSE).
