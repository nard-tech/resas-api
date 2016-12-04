# Gem 'resas-api'

'resas-api' は、[RESAS API](https://opendata.resas-portal.go.jp/) をRubyで扱いやすくするための Gem です。

[RESAS](https://resas.go.jp/) は 'Regional Economy Society Analyzing System' （地域経済経済分析システム）の略で、内閣府、経済産業省、[チームラボ](www.team-lab.com/) によって運営されています。

This gem 'resas-api' enables you to use [RESAS API](https://opendata.resas-portal.go.jp/) by Ruby more easily.

'[RESAS](https://resas.go.jp/)' means 'Regional Economy Society Analyzing System' and is developed by Japanese govenrment (Cabinet Office and 'Ministry of Economy, Trade and Industry')  and [teamLab](www.team-lab.com/).


## 一緒に Gem を育てませんか？ (Contributing)

バグの報告、プルリクエストは[GitHub 'nard-tech/resas-api'](https://github.com/nard-tech/resas-api)へどうぞ。

このプロジェクトは、安全で心地のよい共同作業の場となることを意図しています。参加者の皆さんは、行動規範 [Contributor Covenant](http://contributor-covenant.org)（英語）を遵守するようお願い致します。

Bug reports and pull requests are welcome on GitHub at https://github.com/nard-tech/resas-api.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## ライセンス (License)

このGemは[MITライセンス](http://opensource.org/licenses/MIT)で公開されています。

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


## デモンストレーション (Demonstration)

```ruby
Resas::Api.configure do | config |
  config.access_key = '[ApiAccessKey]'
  config.api_version = 'v1-rc.1'
end
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1-rc.1",
  :adapter=>:net_http
}

Resas::Api.options
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1-rc.1",
  :adapter=>:net_http
}

response_body = Resas::Api.client.get( 'prefectures' )
=> #<Resas::Api::Response::Body:0x007fa719484af0
  @client=#<Resas::Api::Client:0x007fa7194ad298
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1-rc.1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
 @h= {
   "message"=>nil,
   "result"=> [
      {"prefCode"=>1, "prefName"=>"北海道"},
      ........ ,
      {"prefCode"=>47, "prefName"=>"沖縄県"}
    ]
  },
  @options={},
  @path="prefectures"
>
```

## インストールの前に

### API 利用登録

RESAS API 公式ページの[フォーム](https://opendata.resas-portal.go.jp/form.html) で、利用登録を行なってください。

登録時に発行されるアクセスキーが必要になりますので、メモしておきましょう。

なお、Gem の仕様上、環境変数 RESAS_API_ACCESS_KEY にアクセスキーの値を設定することをお勧めします。（詳細は後述）


## インストール

```
gem install resas-api
```

## 他の Gem の内部で使う

```ruby
# Gemfile
gem 'resas-api'
```

or

```ruby
# Xxxx.gemspec
spec.add_runtime_dependency 'resas-api'
```

## require

```ruby
require 'resas/api' # 注意: require 'resas-api' ではない！
```

## 使い方

### 初期設定  

```ruby
Resas::Api.configure do | config |
  config.access_key = '[ApiAccessKey]'
  config.api_version = 'v1-rc.1'
end
```

* access_key: API のアクセスキー
  * 省略した場合は、環境変数 RESAS_API_ACCESS_KEY の値を使用します。
  * 言い換えると、環境変数を設定すれば、Gem を使用する度にアクセスキーを登録する手間を省くことができます。
* api_version: API のバージョン
  * 省略した場合は、バージョン 'v1-rc.1' の API にアクセスします。
  * 現時点 (2016-12-01 02:13+0900) では、公開されている API は v1-rc.1 のみです。したがって、この設定を行う必要はありません。
  * 将来的に新しいバージョンが公開された場合に備え、設定メニューを作ってあります。
* その他の設定メニューもありますが、利用する上で考慮する必要はありません。

#### 設定内容を確認する

```ruby
Resas::Api.options
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1-rc.1",
  :adapter=>:net_http
}
```

#### 設定内容をデフォルトに戻す

```ruby
# 返り値はデフォルトの設定内容
Resas::Api.reset!
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1-rc.1",
  :adapter=>:net_http
}

```

### 具体例

#### 例1 都道府県一覧を取得

```ruby
response_body = Resas::Api.client.get( 'prefectures' )
```

以下の (1) - (4) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'prefectures' ) # (1)

# 'client' は省略可
response_body = Resas::Api.get( 'prefectures' ) # (2)

# 引数はシンボルでもよい
response_body = Resas::Api.get( :prefectures ) # (3)

# もっと、シンプルに
response_body = Resas::Api.prefectures # (4)
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007fa719484af0
  @client=#<Resas::Api::Client:0x007fa7194ad298
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1-rc.1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
 @h= {
   "message"=>nil,
   "result"=> [
      {"prefCode"=>1, "prefName"=>"北海道"},
      ........ ,
      {"prefCode"=>47, "prefName"=>"沖縄県"}
    ]
  },
  @options={},
  @path="prefectures"
>

response_body.result
=> [
  {"prefCode"=>1, "prefName"=>"北海道"},
  {"prefCode"=>2, "prefName"=>"青森県"},
  {"prefCode"=>3, "prefName"=>"岩手県"},
  {"prefCode"=>4, "prefName"=>"宮城県"},
  {"prefCode"=>5, "prefName"=>"秋田県"},
  {"prefCode"=>6, "prefName"=>"山形県"},
  {"prefCode"=>7, "prefName"=>"福島県"},
  {"prefCode"=>8, "prefName"=>"茨城県"},
  {"prefCode"=>9, "prefName"=>"栃木県"},
  {"prefCode"=>10, "prefName"=>"群馬県"},
  {"prefCode"=>11, "prefName"=>"埼玉県"},
  {"prefCode"=>12, "prefName"=>"千葉県"},
  {"prefCode"=>13, "prefName"=>"東京都"},
  {"prefCode"=>14, "prefName"=>"神奈川県"},
  {"prefCode"=>15, "prefName"=>"新潟県"},
  {"prefCode"=>16, "prefName"=>"富山県"},
  {"prefCode"=>17, "prefName"=>"石川県"},
  {"prefCode"=>18, "prefName"=>"福井県"},
  {"prefCode"=>19, "prefName"=>"山梨県"},
  {"prefCode"=>20, "prefName"=>"長野県"},
  {"prefCode"=>21, "prefName"=>"岐阜県"},
  {"prefCode"=>22, "prefName"=>"静岡県"},
  {"prefCode"=>23, "prefName"=>"愛知県"},
  {"prefCode"=>24, "prefName"=>"三重県"},
  {"prefCode"=>25, "prefName"=>"滋賀県"},
  {"prefCode"=>26, "prefName"=>"京都府"},
  {"prefCode"=>27, "prefName"=>"大阪府"},
  {"prefCode"=>28, "prefName"=>"兵庫県"},
  {"prefCode"=>29, "prefName"=>"奈良県"},
  {"prefCode"=>30, "prefName"=>"和歌山県"},
  {"prefCode"=>31, "prefName"=>"鳥取県"},
  {"prefCode"=>32, "prefName"=>"島根県"},
  {"prefCode"=>33, "prefName"=>"岡山県"},
  {"prefCode"=>34, "prefName"=>"広島県"},
  {"prefCode"=>35, "prefName"=>"山口県"},
  {"prefCode"=>36, "prefName"=>"徳島県"},
  {"prefCode"=>37, "prefName"=>"香川県"},
  {"prefCode"=>38, "prefName"=>"愛媛県"},
  {"prefCode"=>39, "prefName"=>"高知県"},
  {"prefCode"=>40, "prefName"=>"福岡県"},
  {"prefCode"=>41, "prefName"=>"佐賀県"},
  {"prefCode"=>42, "prefName"=>"長崎県"},
  {"prefCode"=>43, "prefName"=>"熊本県"},
  {"prefCode"=>44, "prefName"=>"大分県"},
  {"prefCode"=>45, "prefName"=>"宮崎県"},
  {"prefCode"=>46, "prefName"=>"鹿児島県"},
  {"prefCode"=>47, "prefName"=>"沖縄県"}
]
```

* データ取得後に、アクセスした URL を知りたい

```ruby
response_body.path
#=> #<URI::HTTPS https://opendata.resas-portal.go.jp/api/v1-rc.1/prefectures>

response_body.path( full: false )
=> #<URI::Generic prefectures>
```

* データ取得前に、アクセスする URL を知りたい（通信なし）

```ruby
Resas::Api.client.path( 'prefectures' )
=> #<URI::HTTPS https://opendata.resas-portal.go.jp/api/v1-rc.1/prefectures>

Resas::Api.client.path( 'prefectures', full: false )
=> #<URI::Generic prefectures>
```


#### 例2 島根県の市町村一覧を取得

```ruby
response_body = Resas::Api.client.get( 'cities', { 'prefCode' => 32 } )
```

以下の (1) - (9) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'cities', { 'prefCode' => 32 } ) # (1)

# Resas::Api.client.get( ... ) は、 Resas::Api.get( ... ) と記述できる。
response_body = Resas::Api.get( 'cities', { 'prefCode' => 32 } ) # (2)

# 引数はシンボルでもよい。オプションはキーワード引数として記述してもよい。
response_body = Resas::Api.get( :cities, prefCode: 32 ) # (3)

# オプションのキーは snake case でもよい。
response_body = Resas::Api.get( 'cities', { 'pref_code' => 32 } ) # (4)

# キーワード引数も、 snake case でよい。
response_body = Resas::Api.get( :cities, pref_code: 32 ) # (5)

# もっと、シンプルに。
response_body = Resas::Api.cities( 'prefCode' => 32 ) # (6)
response_body = Resas::Api.cities( 'pref_code' => 32 ) # (7)
response_body = Resas::Api.cities( prefCode: 32 ) # (8)
response_body = Resas::Api.cities( pref_code: 32 ) # (9)
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007f8dfbe1aec0
  @client=#<Resas::Api::Client:0x007f8dfa8288d8
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1-rc.1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
  @h= {
    "message"=>nil,
    "result"=> [
      {"prefCode"=>32, "cityCode"=>"32201", "cityName"=>"松江市", "bigCityFlag"=>"0"},
      ........ ,
      {"prefCode"=>32, "cityCode"=>"32528", "cityName"=>"隠岐の島町", "bigCityFlag"=>"0"}
    ]
  },
  @options={"prefCode"=>"32"},
  @path="cities"
>

response_body.result
=> [
  {"prefCode"=>32, "cityCode"=>"32201", "cityName"=>"松江市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32202", "cityName"=>"浜田市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32203", "cityName"=>"出雲市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32204", "cityName"=>"益田市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32205", "cityName"=>"大田市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32206", "cityName"=>"安来市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32207", "cityName"=>"江津市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32209", "cityName"=>"雲南市", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32343", "cityName"=>"奥出雲町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32386", "cityName"=>"飯南町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32441", "cityName"=>"川本町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32448", "cityName"=>"美郷町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32449", "cityName"=>"邑南町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32501", "cityName"=>"津和野町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32505", "cityName"=>"吉賀町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32525", "cityName"=>"海士町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32526", "cityName"=>"西ノ島町", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32527", "cityName"=>"知夫村", "bigCityFlag"=>"0"},
  {"prefCode"=>32, "cityCode"=>"32528", "cityName"=>"隠岐の島町", "bigCityFlag"=>"0"}
]
```

#### 例3 島根県のIT系産業の推移

##### Step1 産業中分類コードを取得

```ruby
response_body = Resas::Api.client.get( 'industries/middle' )
```

以下の (1) - (6) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'industries/middle' ) # (1)

# Resas::Api.client.get( ... ) は、 Resas::Api.get( ... ) と記述できる。
response_body = Resas::Api.get( 'industries/middle' ) # (2)

# 'industries/middle' は、2つの引数 'industries', 'middle' に分割できる。
response_body = Resas::Api.get( 'industries', 'middle' ) # (4)

# 引数はシンボルでもよい。
response_body = Resas::Api.get( :industries, :middle ) # (5)

# もっとシンプルに。
response_body = Resas::Api.industries_middle # (6)
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007ffb2413cfa0
  @client= #<Resas::Api::Client:0x007ffb23b45c78
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1-rc.1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
  @h= {
    "message"=>nil,
    "result"=> [
      {"simcCode"=>"01", "sicCode"=>"A", "simcName"=>"農業"},
      ........ ,
      {"simcCode"=>"99", "sicCode"=>"T", "simcName"=>"分類不能の産業"}
    ]
  },
  @options={},
  @path="industries/middle"
>

response_body.result
=> [
  {"simcCode"=>"01", "sicCode"=>"A", "simcName"=>"農業"},
  {"simcCode"=>"02", "sicCode"=>"A", "simcName"=>"林業"},
  ........ ,
  {"simcCode"=>"39", "sicCode"=>"G", "simcName"=>"情報サービス業"},
  {"simcCode"=>"40", "sicCode"=>"G", "simcName"=>"インターネット附随サービス業"},
  ........ ,
  {"simcCode"=>"99", "sicCode"=>"T", "simcName"=>"分類不能の産業"}
]
```

##### Step2 「情報サービス業」について

```ruby
response_body = Resas::Api.client.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => 32, 'simcCode' => 39 } )
```

以下の (1) - (8) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => 32, 'simcCode' => 39 } ) # (1)

# Resas::Api.client.get( ... ) は、 Resas::Api.get( ... ) と記述できる。
response_body = Resas::Api.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => 32, 'simcCode' => 39 } ) # (2)

# 'industry/power/forManufacturerEstablishments' は、3つの引数 'industry', 'power', 'forManufacturerEstablishments' に分割できる。
response_body = Resas::Api.get( 'industry', 'power', 'forManufacturerEstablishments', { 'prefCode' => 32, 'simcCode' => 39 } ) # (3)

# 引数はシンボルでもよい。オプションはキーワード引数として記述してもよい。
response_body = Resas::Api.get( :industry, :power, :forManufacturerEstablishments, prefCode: 32, simcCode: 39 ) # (4)

# 引数、オプション、キーワード引数の文字列やシンボルは snake case でもよい。
response_body = Resas::Api.get( 'industry', 'power', 'for_manufacturer_establishments', { 'pref_code' => 32, 'simc_code' => 39 } ) # (5)
response_body = Resas::Api.get( :industry, :power, :for_manufacturer_establishments, pref_code: 32, simc_code: 39 ) # (6)

# もっと、シンプルに。
response_body = Resas::Api.industry_power_for_manufacturer_establishments( { 'prefCode' => 32, 'simcCode' => 39 } ) # (7)
response_body = Resas::Api.industry_power_for_manufacturer_establishments( pref_code: 32, simc_code: 39 ) # (8)
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007fb4ed50c9f0
  @client= #<Resas::Api::Client:0x007fb4ed53c880
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1-rc.1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
  @h= {
    "message"=>nil,
    "result"=> {
      "prefCode"=>32,
      "prefName"=>"島根県",
      "sicCode"=>"",
      "sicName"=>"",
      "simcCode"=>"39",
      "simcName"=>"情報サービス業",
      "establishments"=> [{
        "label"=>"退出",
        "data"=> [
          {"year"=>1990, "value"=>228289.5115, "labor"=>11824.5855, "employee"=>469.2592},
          ........ ,
          {"year"=>2003, "value"=>215339.9399, "labor"=>10763.8282, "employee"=>378.0257}
        ]
      }, {
        "label"=>"継続",
        "data"=> [
          {"year"=>1993, "value"=>1541328.7813, "labor"=>18204.1906, "employee"=>1570.9718},
          ........ ,
          {"year"=>1995, "value"=>1710052.2529, "labor"=>19394.3164, "employee"=>1575.867}
        ]
      }, {
        "label"=>"全事業所",
        "data"=> [
          {"year"=>1996, "value"=>999714.6202, "labor"=>21488.5858, "employee"=>980.1551},
          ........ ,
          {"year"=>2010, "value"=>1454410.5728, "labor"=>21505.4697, "employee"=>1355.4744}
        ]
      }, {
        "label"=>"参入",
        "data"=> [
          {"year"=>2004, "value"=>397626.0687, "labor"=>13908.7543, "employee"=>478.4117},
          ........ ,
          {"year"=>1993, "value"=>176387.8019, "labor"=>7190.0639, "employee"=>279.0055}
        ]
      }]
    }
  },
  @options={"prefCode"=>"32", "simcCode"=>"39"},
  @path="industry/power/forManufacturerEstablishments"
>

response_body.result
=> {
  "prefCode"=>32,
  "prefName"=>"島根県",
  "sicCode"=>"",
  "sicName"=>"",
  "simcCode"=>"39",
  "simcName"=>"情報サービス業",
  "establishments"=> [{
    "label"=>"退出",
    "data"=> [
      {"year"=>1990, "value"=>228289.5115, "labor"=>11824.5855, "employee"=>469.2592},
      {"year"=>1994, "value"=>246156.5092, "labor"=>12576.6664, "employee"=>424.4179},
      {"year"=>2005, "value"=>172614.9212, "labor"=>11025.2759, "employee"=>294.9839},
      {"year"=>2004, "value"=>194650.7915, "labor"=>10650.7966, "employee"=>310.6319},
      {"year"=>1995, "value"=>245173.3093, "labor"=>12623.7602, "employee"=>436.6148},
      {"year"=>2002, "value"=>228834.464, "labor"=>10752.8457, "employee"=>388.1532},
      {"year"=>1996, "value"=>252351.0898, "labor"=>12899.1338, "employee"=>429.7316},
      {"year"=>2001, "value"=>247699.4077, "labor"=>13526.476, "employee"=>380.4803},
      {"year"=>1997, "value"=>261334.6525, "labor"=>13045.7252, "employee"=>407.5875},
      {"year"=>2000, "value"=>251502.8521, "labor"=>11846.1017, "employee"=>395.0562},
      {"year"=>1998, "value"=>254751.8887, "labor"=>13368.4234, "employee"=>407.422},
      {"year"=>2008, "value"=>112604.2421, "labor"=>6877.607, "employee"=>156.2736},
      {"year"=>2006, "value"=>160175.3076, "labor"=>9549.0718, "employee"=>212.656},
      {"year"=>1993, "value"=>223428.3737, "labor"=>11723.2741, "employee"=>432.5216},
      {"year"=>1991, "value"=>252433.2956, "labor"=>12378.3195, "employee"=>479.9959},
      {"year"=>2009, "value"=>24212.1667, "labor"=>2464.2309, "employee"=>52.7334},
      {"year"=>1999, "value"=>232312.0591, "labor"=>11516.7491, "employee"=>389.8243},
      {"year"=>1992, "value"=>249417.5043, "labor"=>12816.9761, "employee"=>465.8778},
      {"year"=>2007, "value"=>140539.3581, "labor"=>6561.8033, "employee"=>202.1015},
      {"year"=>2003, "value"=>215339.9399, "labor"=>10763.8282, "employee"=>378.0257}
    ]
  }, {
    "label"=>"継続",
    "data"=> [
      {"year"=>1993, "value"=>1541328.7813, "labor"=>18204.1906, "employee"=>1570.9718},
      {"year"=>2004, "value"=>1536320.1651, "labor"=>17821.0405, "employee"=>1350.3666},
      {"year"=>1992, "value"=>1594681.0497, "labor"=>18582.4917, "employee"=>1628.4712},
      {"year"=>2006, "value"=>1912616.2217, "labor"=>19010.0955, "employee"=>1657.65},
      {"year"=>2000, "value"=>1890521.5364, "labor"=>20841.7235, "employee"=>1452.6925},
      {"year"=>2010, "value"=>1744646.2774, "labor"=>18937.134, "employee"=>1576.4885},
      {"year"=>2005, "value"=>1603598.2413, "labor"=>18150.7059, "employee"=>1412.0105},
      {"year"=>1991, "value"=>1581716.6448, "labor"=>18318.8178, "employee"=>1559.386},
      {"year"=>2008, "value"=>1575018.3985, "labor"=>17306.8405, "employee"=>1659.0983},
      {"year"=>2007, "value"=>2038223.8799, "labor"=>19097.566, "employee"=>1691.2847},
      {"year"=>2009, "value"=>1315037.1713, "labor"=>16452.4924, "employee"=>1524.4266},
      {"year"=>1990, "value"=>1466971.4242, "labor"=>17342.8664, "employee"=>1506.0091},
      {"year"=>1994, "value"=>1520357.4098, "labor"=>18164.9064, "employee"=>1571.9189},
      {"year"=>2003, "value"=>1429992.8761, "labor"=>17542.0177, "employee"=>1339.4055},
      {"year"=>1999, "value"=>1454382.2933, "labor"=>17360.0497, "employee"=>1485.4376},
      {"year"=>1998, "value"=>1749459.1377, "labor"=>19082.9991, "employee"=>1508.6666},
      {"year"=>1996, "value"=>1643114.5735, "labor"=>17924.4969, "employee"=>1493.6273},
      {"year"=>1997, "value"=>1669424.7789, "labor"=>19662.9859, "employee"=>1523.7531},
      {"year"=>2002, "value"=>1591641.5655, "labor"=>18803.1011, "employee"=>1434.1532},
      {"year"=>2001, "value"=>1721642.4968, "labor"=>20099.0283, "employee"=>1491.309},
      {"year"=>1995, "value"=>1710052.2529, "labor"=>19394.3164, "employee"=>1575.867}
    ]
  }, {
    "label"=>"全事業所",
    "data"=> [
      {"year"=>1996, "value"=>999714.6202, "labor"=>21488.5858, "employee"=>980.1551},
      {"year"=>1999, "value"=>821278.4939, "labor"=>19982.9276, "employee"=>925.2066},
      {"year"=>2008, "value"=>1158459.391, "labor"=>19671.9404, "employee"=>1243.0025},
      {"year"=>2003, "value"=>848426.4971, "labor"=>18293.9959, "employee"=>954.3824},
      {"year"=>1990, "value"=>816742.8026, "labor"=>17765.8063, "employee"=>925.5405},
      {"year"=>1997, "value"=>994096.4496, "labor"=>21694.6404, "employee"=>982.646},
      {"year"=>2009, "value"=>1120729.6926, "labor"=>18810.9847, "employee"=>1291.3524},
      {"year"=>1998, "value"=>896327.8068, "labor"=>21885.5155, "employee"=>887.6193},
      {"year"=>2007, "value"=>1414289.9913, "labor"=>21845.3278, "employee"=>1242.9473},
      {"year"=>2000, "value"=>1026919.6797, "labor"=>22708.5883, "employee"=>937.7357},
      {"year"=>1994, "value"=>834963.8803, "labor"=>20079.1531, "employee"=>916.6164},
      {"year"=>1992, "value"=>892309.8233, "labor"=>19425.0119, "employee"=>936.264},
      {"year"=>2002, "value"=>1040923.2731, "labor"=>21136.3605, "employee"=>1035.7466},
      {"year"=>2004, "value"=>1052606.0482, "labor"=>20882.9096, "employee"=>1040.2778},
      {"year"=>1993, "value"=>761714.6055, "labor"=>19180.8875, "employee"=>868.0415},
      {"year"=>2005, "value"=>1097675.1225, "labor"=>21263.5005, "employee"=>1055.3825},
      {"year"=>1995, "value"=>894754.2529, "labor"=>21641.4756, "employee"=>912.0364},
      {"year"=>2001, "value"=>1026162.4967, "labor"=>22121.3988, "employee"=>997.9014},
      {"year"=>2006, "value"=>1303081.0073, "labor"=>21927.4923, "employee"=>1172.6099},
      {"year"=>1991, "value"=>815498.1297, "labor"=>18308.2132, "employee"=>920.5647},
      {"year"=>2010, "value"=>1454410.5728, "labor"=>21505.4697, "employee"=>1355.4744}
    ]
  }, {
    "label"=>"参入",
    "data"=> [
      {"year"=>2004, "value"=>397626.0687, "labor"=>13908.7543, "employee"=>478.4117},
      {"year"=>2010, "value"=>309211.0916, "labor"=>12514.4759, "employee"=>539.1566},
      {"year"=>1999, "value"=>329669.777, "labor"=>13587.2308, "employee"=>402.873},
      {"year"=>2009, "value"=>293512.6452, "labor"=>11642.5747, "employee"=>546.3157},
      {"year"=>2000, "value"=>292668.0053, "labor"=>12329.2975, "employee"=>401.7599},
      {"year"=>2005, "value"=>426327.0597, "labor"=>14101.3639, "employee"=>492.9803},
      {"year"=>1995, "value"=>209916.7064, "labor"=>9608.0442, "employee"=>273.7817},
      {"year"=>2001, "value"=>336097.6237, "labor"=>13086.9737, "employee"=>439.7318},
      {"year"=>2006, "value"=>511244.8163, "labor"=>15324.4134, "employee"=>721.0766},
      {"year"=>2007, "value"=>595799.1046, "labor"=>17711.6288, "employee"=>698.0141},
      {"year"=>2002, "value"=>294434.8329, "labor"=>12202.2469, "employee"=>377.0076},
      {"year"=>2003, "value"=>248438.8056, "labor"=>11306.9234, "employee"=>382.7164},
      {"year"=>2008, "value"=>501895.1731, "labor"=>15790.4269, "employee"=>634.4234},
      {"year"=>1992, "value"=>111136.5556, "labor"=>4369.3754, "employee"=>208.0111},
      {"year"=>1991, "value"=>89773.7417, "labor"=>2908.2947, "employee"=>177.1083},
      {"year"=>1997, "value"=>275594.3506, "labor"=>12113.4417, "employee"=>312.0749},
      {"year"=>1996, "value"=>186481.339, "labor"=>9310.5841, "employee"=>302.5917},
      {"year"=>1994, "value"=>204699.9223, "labor"=>8731.9007, "employee"=>265.0887},
      {"year"=>1998, "value"=>335096.1129, "labor"=>15291.9184, "employee"=>366.7828},
      {"year"=>1993, "value"=>176387.8019, "labor"=>7190.0639, "employee"=>279.0055}
    ]
  }]
}
```

##### Step3 インターネット附随サービス業

```ruby
response_body = Resas::Api.client.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => 32, 'simcCode' => 40 } )
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007fb4ed5357b0
  @client= #<Resas::Api::Client:0x007fb4ed575040
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1-rc.1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
  @h= {
    "message"=>nil,
    "result"=> {
      "prefCode"=>32,
      "prefName"=>"島根県",
      "sicCode"=>"",
      "sicName"=>"",
      "simcCode"=>"40",
      "simcName"=>"インターネット附随サービス業",
      "establishments"=> [{
        "label"=>"退出",
        "data"=> [
          {"year"=>1990, "value"=>228289.5115, "labor"=>11824.5855, "employee"=>469.2592},
          ........ ,
          {"year"=>2003, "value"=>215339.9399, "labor"=>10763.8282, "employee"=>378.0257}
        ]
      }, {
        "label"=>"継続",
        "data"=> [
          {"year"=>1993, "value"=>1541328.7813, "labor"=>18204.1906, "employee"=>1570.9718},
          ........ ,
          {"year"=>1995, "value"=>1710052.2529, "labor"=>19394.3164, "employee"=>1575.867}
        ]
      }, {
        "label"=>"全事業所",
        "data"=> [
          {"year"=>1996, "value"=>999714.6202, "labor"=>21488.5858, "employee"=>980.1551},
          ........ ,
          {"year"=>2010, "value"=>1454410.5728, "labor"=>21505.4697, "employee"=>1355.4744}
        ]
      }, {
        "label"=>"参入",
        "data"=> [
          {"year"=>2004, "value"=>397626.0687, "labor"=>13908.7543, "employee"=>478.4117},
          ........ ,
          {"year"=>1993, "value"=>176387.8019, "labor"=>7190.0639, "employee"=>279.0055}
        ]
      }]
    }
  },
  @options={"prefCode"=>"32", "simcCode"=>"40"},
  @path="industry/power/forManufacturerEstablishments"
>

response_body.result
=> {
  "message"=>nil,
  "result"=> {
    "prefCode"=>32,
    "prefName"=>"島根県",
    "sicCode"=>"",
    "sicName"=>"",
    "simcCode"=>"40",
    "simcName"=>"インターネット附随サービス業",
    "establishments"=> [{
      "label"=>"退出",
      "data"=> [
        {"year"=>1990, "value"=>228289.5115, "labor"=>11824.5855, "employee"=>469.2592},
        {"year"=>1994, "value"=>246156.5092, "labor"=>12576.6664, "employee"=>424.4179},
        {"year"=>2005, "value"=>172614.9212, "labor"=>11025.2759, "employee"=>294.9839},
        {"year"=>2004, "value"=>194650.7915, "labor"=>10650.7966, "employee"=>310.6319},
        {"year"=>1995, "value"=>245173.3093, "labor"=>12623.7602, "employee"=>436.6148},
        {"year"=>2002, "value"=>228834.464, "labor"=>10752.8457, "employee"=>388.1532},
        {"year"=>1996, "value"=>252351.0898, "labor"=>12899.1338, "employee"=>429.7316},
        {"year"=>2001, "value"=>247699.4077, "labor"=>13526.476, "employee"=>380.4803},
        {"year"=>1997, "value"=>261334.6525, "labor"=>13045.7252, "employee"=>407.5875},
        {"year"=>2000, "value"=>251502.8521, "labor"=>11846.1017, "employee"=>395.0562},
        {"year"=>1998, "value"=>254751.8887, "labor"=>13368.4234, "employee"=>407.422},
        {"year"=>2008, "value"=>112604.2421, "labor"=>6877.607, "employee"=>156.2736},
        {"year"=>2006, "value"=>160175.3076, "labor"=>9549.0718, "employee"=>212.656},
        {"year"=>1993, "value"=>223428.3737, "labor"=>11723.2741, "employee"=>432.5216},
        {"year"=>1991, "value"=>252433.2956, "labor"=>12378.3195, "employee"=>479.9959},
        {"year"=>2009, "value"=>24212.1667, "labor"=>2464.2309, "employee"=>52.7334},
        {"year"=>1999, "value"=>232312.0591, "labor"=>11516.7491, "employee"=>389.8243},
        {"year"=>1992, "value"=>249417.5043, "labor"=>12816.9761, "employee"=>465.8778},
        {"year"=>2007, "value"=>140539.3581, "labor"=>6561.8033, "employee"=>202.1015},
        {"year"=>2003, "value"=>215339.9399, "labor"=>10763.8282, "employee"=>378.0257}
      ]
    }, {
      "label"=>"継続",
      "data"=> [
        {"year"=>1993, "value"=>1541328.7813, "labor"=>18204.1906, "employee"=>1570.9718},
        {"year"=>2004, "value"=>1536320.1651, "labor"=>17821.0405, "employee"=>1350.3666},
        {"year"=>1992, "value"=>1594681.0497, "labor"=>18582.4917, "employee"=>1628.4712},
        {"year"=>2006, "value"=>1912616.2217, "labor"=>19010.0955, "employee"=>1657.65},
        {"year"=>2000, "value"=>1890521.5364, "labor"=>20841.7235, "employee"=>1452.6925},
        {"year"=>2010, "value"=>1744646.2774, "labor"=>18937.134, "employee"=>1576.4885},
        {"year"=>2005, "value"=>1603598.2413, "labor"=>18150.7059, "employee"=>1412.0105},
        {"year"=>1991, "value"=>1581716.6448, "labor"=>18318.8178, "employee"=>1559.386},
        {"year"=>2008, "value"=>1575018.3985, "labor"=>17306.8405, "employee"=>1659.0983},
        {"year"=>2007, "value"=>2038223.8799, "labor"=>19097.566, "employee"=>1691.2847},
        {"year"=>2009, "value"=>1315037.1713, "labor"=>16452.4924, "employee"=>1524.4266},
        {"year"=>1990, "value"=>1466971.4242, "labor"=>17342.8664, "employee"=>1506.0091},
        {"year"=>1994, "value"=>1520357.4098, "labor"=>18164.9064, "employee"=>1571.9189},
        {"year"=>2003, "value"=>1429992.8761, "labor"=>17542.0177, "employee"=>1339.4055},
        {"year"=>1999, "value"=>1454382.2933, "labor"=>17360.0497, "employee"=>1485.4376},
        {"year"=>1998, "value"=>1749459.1377, "labor"=>19082.9991, "employee"=>1508.6666},
        {"year"=>1996, "value"=>1643114.5735, "labor"=>17924.4969, "employee"=>1493.6273},
        {"year"=>1997, "value"=>1669424.7789, "labor"=>19662.9859, "employee"=>1523.7531},
        {"year"=>2002, "value"=>1591641.5655, "labor"=>18803.1011, "employee"=>1434.1532},
        {"year"=>2001, "value"=>1721642.4968, "labor"=>20099.0283, "employee"=>1491.309},
        {"year"=>1995, "value"=>1710052.2529, "labor"=>19394.3164, "employee"=>1575.867}
      ]
    }, {
      "label"=>"全事業所",
      "data"=> [
        {"year"=>1996, "value"=>999714.6202, "labor"=>21488.5858, "employee"=>980.1551},
        {"year"=>1999, "value"=>821278.4939, "labor"=>19982.9276, "employee"=>925.2066},
        {"year"=>2008, "value"=>1158459.391, "labor"=>19671.9404, "employee"=>1243.0025},
        {"year"=>2003, "value"=>848426.4971, "labor"=>18293.9959, "employee"=>954.3824},
        {"year"=>1990, "value"=>816742.8026, "labor"=>17765.8063, "employee"=>925.5405},
        {"year"=>1997, "value"=>994096.4496, "labor"=>21694.6404, "employee"=>982.646},
        {"year"=>2009, "value"=>1120729.6926, "labor"=>18810.9847, "employee"=>1291.3524},
        {"year"=>1998, "value"=>896327.8068, "labor"=>21885.5155, "employee"=>887.6193},
        {"year"=>2007, "value"=>1414289.9913, "labor"=>21845.3278, "employee"=>1242.9473},
        {"year"=>2000, "value"=>1026919.6797, "labor"=>22708.5883, "employee"=>937.7357},
        {"year"=>1994, "value"=>834963.8803, "labor"=>20079.1531, "employee"=>916.6164},
        {"year"=>1992, "value"=>892309.8233, "labor"=>19425.0119, "employee"=>936.264},
        {"year"=>2002, "value"=>1040923.2731, "labor"=>21136.3605, "employee"=>1035.7466},
        {"year"=>2004, "value"=>1052606.0482, "labor"=>20882.9096, "employee"=>1040.2778},
        {"year"=>1993, "value"=>761714.6055, "labor"=>19180.8875, "employee"=>868.0415},
        {"year"=>2005, "value"=>1097675.1225, "labor"=>21263.5005, "employee"=>1055.3825},
        {"year"=>1995, "value"=>894754.2529, "labor"=>21641.4756, "employee"=>912.0364},
        {"year"=>2001, "value"=>1026162.4967, "labor"=>22121.3988, "employee"=>997.9014},
        {"year"=>2006, "value"=>1303081.0073, "labor"=>21927.4923, "employee"=>1172.6099},
        {"year"=>1991, "value"=>815498.1297, "labor"=>18308.2132, "employee"=>920.5647},
        {"year"=>2010, "value"=>1454410.5728, "labor"=>21505.4697, "employee"=>1355.4744}
      ]
    }, {
      "label"=>"参入",
      "data"=> [
        {"year"=>2004, "value"=>397626.0687, "labor"=>13908.7543, "employee"=>478.4117},
        {"year"=>2010, "value"=>309211.0916, "labor"=>12514.4759, "employee"=>539.1566},
        {"year"=>1999, "value"=>329669.777, "labor"=>13587.2308, "employee"=>402.873},
        {"year"=>2009, "value"=>293512.6452, "labor"=>11642.5747, "employee"=>546.3157},
        {"year"=>2000, "value"=>292668.0053, "labor"=>12329.2975, "employee"=>401.7599},
        {"year"=>2005, "value"=>426327.0597, "labor"=>14101.3639, "employee"=>492.9803},
        {"year"=>1995, "value"=>209916.7064, "labor"=>9608.0442, "employee"=>273.7817},
        {"year"=>2001, "value"=>336097.6237, "labor"=>13086.9737, "employee"=>439.7318},
        {"year"=>2006, "value"=>511244.8163, "labor"=>15324.4134, "employee"=>721.0766},
        {"year"=>2007, "value"=>595799.1046, "labor"=>17711.6288, "employee"=>698.0141},
        {"year"=>2002, "value"=>294434.8329, "labor"=>12202.2469, "employee"=>377.0076},
        {"year"=>2003, "value"=>248438.8056, "labor"=>11306.9234, "employee"=>382.7164},
        {"year"=>2008, "value"=>501895.1731, "labor"=>15790.4269, "employee"=>634.4234},
        {"year"=>1992, "value"=>111136.5556, "labor"=>4369.3754, "employee"=>208.0111},
        {"year"=>1991, "value"=>89773.7417, "labor"=>2908.2947, "employee"=>177.1083},
        {"year"=>1997, "value"=>275594.3506, "labor"=>12113.4417, "employee"=>312.0749},
        {"year"=>1996, "value"=>186481.339, "labor"=>9310.5841, "employee"=>302.5917},
        {"year"=>1994, "value"=>204699.9223, "labor"=>8731.9007, "employee"=>265.0887},
        {"year"=>1998, "value"=>335096.1129, "labor"=>15291.9184, "employee"=>366.7828},
        {"year"=>1993, "value"=>176387.8019, "labor"=>7190.0639, "employee"=>279.0055}
      ]
    }]
  }
}
```
