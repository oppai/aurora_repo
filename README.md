# AuroraRepo

## Description

AWS AuroraでEctoを扱う際に、Ectoをそのまま使うとConnection Poolが問題を起こすケースがある。
そのようなケースで適切にコネクションを切断するためにこのモジュールを利用すること

### failover時の挙動

failoverからの復帰時におけるnameserverの反映までの間、
readonlyのendpointに対してmasterとして接続してしまい更新系SQLを実行してしまうケースがある。

その際は1290エラーが発生するので、適切にコネクションを切断すること。

また、failoverの復旧を早めるために、mariaexライブラリをカスタマイズしたものを利用する。

以下のリポジトリのfailover対応ブランチから適切なバージョンを選択する

https://github.com/xflagstudio/mariaex

### zero-downtimeでのバージョンアップ時の挙動

Ectoは、prepared statementをコネクションごとにキャッシュする。
しかしゼロダウンタイムでaurora側のバージョンアップなどを行った際は、
コネクションは切断されないまま、サーバー側でprepared statementがクリアされてしまう。

そのため、サーバー上に存在しないprepared statementを利用しようとして1243エラーが発生する。
この場合もコネクションを適切に切断し、Ecto側のprepared statementをクリアしなければならない。

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aurora_repo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aurora_repo, github: "xflagstudio/aurora_repo", tag: "0.1.1"}
    {:mariaex, github: "xflagstudio/mariaex", branch: "aurora_failover_0_8_4", override: true}
  ]
end
```

## Usage

Ecto.Repoの代わりにAuroraRepoをuseするだけです。

```elixir
defmodule YourRepo do
  use AuroraRepo, otp_app: :your_app
end
```
