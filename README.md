<p align="center">
  <img src="http://img.shields.io/static/v1?label=STATUS&message=Concluded&color=blue&style=flat"/>
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/Rafa-KozAnd/Ignite_Elixir_Challenge_04">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/top/Rafa-KozAnd/Ignite_Elixir_Challenge_04">
  <img alt="GitHub repo file count" src="https://img.shields.io/github/directory-file-count/Rafa-KozAnd/Ignite_Elixir_Challenge_04">
  <img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/Rafa-KozAnd/Ignite_Elixir_Challenge_04">
  <img alt="GitHub language count" src="https://img.shields.io/github/license/Rafa-KozAnd/Ignite_Elixir_Challenge_04">
</p>

# Ignite_Elixir_Challenge_04

Elixir challenge done with 'Rocketseat' Ignite course. ("Desafio 04 - Gerando relatórios com paralelismo &amp; Relatório de reservas de voos &amp; Testando a aplicação")

# Desafio - Gerando relatórios com paralelismo
## 💻 Sobre o desafio

Nesse desafio, você deverá gerar o mesmo relatório com os mesmos dados do desafio anterior mas dessa vez os dados estão fracionados em três arquivos com 10 mil linhas cada e o relatório deve ser gerado usando esses três arquivos em paralelo.

Observe que o resultado final do cálculo de horas de cada pessoa para ano, mês e total de horas deve ser o mesmo do desafio anterior, já que os dados continuam iguais.

# Desafio - Reservas de voos
## 💻 Sobre o desafio

Nesse desafio, você deverá criar uma aplicação de reserva de voos, onde haverá o cadastro de usuários e o cadastro de reservas para um usuário.

A struct do usuário deverá possuir os seguintes campos:

%User{
	id: id,
	name: name,
	email: email,
	cpf: cpf
}

**Obs:** O Id deve ser gerado automaticamente, pode ser um inteiro ou um UUID, mas não pode se repetir.

A struct da reserva deverá possuir os seguintes campos:

%Booking{
	id: id,
	complete_date: complete_date,
	local_origin: local_origin,
	local_destination: local_destination,
	user_id: user_id
}

O campo data_completa deverá ser uma NaiveDateTime, que é um formato de data sem fuso horário e com funções auxiliares.

# Desafio - Relatório de reservas de voos
## 💻 Sobre o desafio

Nesse desafio, você deverá incrementar a sua solução do [desafio anterior](https://www.notion.so/Desafio-01-Reservas-de-voos-f5fd8814ce904360b2500449143e589e). Agora deverá ser possível também gerar relatórios das reservas de voos de acordo com o intervalo de tempo especificado na chamada da função.

Dito isso, é esperado que a função receba dois parâmetros: data inicial e data final. Todas as reservas que estiverem agendadas para esse intervalo de tempo, deve entrar no arquivo CSV do relatório.

# Desafio - Testando a aplicação
## 💻 Sobre o desafio

Nesse desafio, você deverá criar outros testes com o objetivo de completar 100% na cobertura excoveralls. Para isso, utilize a lib do excoveralls, adicione a dependência dele no seu mix.exs e essas configurações.

def project do
  [
    app: :excoveralls,
    version: "1.0.0",
    elixir: "~> 1.0.0",
    deps: deps(),
    test_coverage: [tool: ExCoveralls],
    preferred_cli_env: [
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test
    ]
    # if you want to use espec,
    # test_coverage: [tool: ExCoveralls, test_task: "espec"]
  ]
end

defp deps do
  [
    {:excoveralls, "~> 0.10", only: :test},
  ]
end
