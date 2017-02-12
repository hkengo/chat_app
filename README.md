## デプロイ先URL
https://chat-app-rails.herokuapp.com

## herokuへのデプロイ方法

### redistogoの設定
```
$ heroku addons:create redistogo
```

環境変数を設定(`seacrets.yml`にて読まれる)
```ruby
ENV["REDISTOGO_URL"] = 'redis://username:password@my.host:6389'
```

```ruby
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
```

```ruby
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:url => uri)
```

```ruby
ENV["REDIS_URL"] = ENV["REDISTOGO_URL"] = 'redis://username:password@my.host:6389'
```

### デプロイ
heroku上にサーバー作成
```
$ heroku create APP_NAME
```
herokuにmasterをpush
```
$ git push heroku master
```
herokuにfor_herokuブランチをpush
```
$ git push heroku for_heroku:master
```
サーバーの再起動
```
$ heroku restart -app APP_NAME
```

### 設定確認
herokuのログを見る(リアルタイム)
```
$ heroku logs --tail
```
herokuのサーバー情報
```
$ heroku info
```
herokuの環境変数一覧
```
$ heroku config
```
herokuのアプリをブラウザで開く
```
$ heroku open
```
