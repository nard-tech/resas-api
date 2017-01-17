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
  config.api_version = 'v1'
end
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1",
  :adapter=>:net_http
}

Resas::Api.options
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1",
  :adapter=>:net_http
}

response_body = Resas::Api.client.get( 'prefectures' )
=> #<Resas::Api::Response::Body:0x007fa719484af0
  @client=#<Resas::Api::Client:0x007fa7194ad298
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1",
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
  config.api_version = 'v1'
end
```

* access_key: API のアクセスキー
  * 省略した場合は、環境変数 RESAS_API_ACCESS_KEY の値を使用します。
  * 言い換えると、環境変数を設定すれば、Gem を使用する度にアクセスキーを登録する手間を省くことができます。
* api_version: API のバージョン
  * 省略した場合は、バージョン`v1`の API にアクセスします。
　　* `v1`以外のバージョンのAPIを利用する場合は指定が必須です。
    * 補足: API公開時のバージョンは`v1-rc.1`でしたが、2016年12月末頃より`v1`が公開されました。現時点 (2017-01-18 05:55+0900) では`v1-rc.1`へアクセスが可能です。
    * 注意: APIの利用規約が変更されたため、[RESAS-API - マイページ](https://opendata.resas-portal.go.jp/mypage.html) 内で新規約への同意をしないとAPIのアクセスができなくなるようです。
* その他の設定メニューもありますが、利用する上で考慮する必要はありません。

#### 設定内容を確認する

```ruby
Resas::Api.options
=> {
  :access_key=>"[ApiAccessKey]",
  :base_url=>"https://opendata.resas-portal.go.jp",
  :format=>:json,
  :api_version=>"v1",
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
  :api_version=>"v1",
  :adapter=>:net_http
}

```

### 具体例

#### 例1 都道府県一覧を取得

* 利用するAPI
  * [都道府県一覧](https://opendata.resas-portal.go.jp/docs/api/v1/prefectures.html)

```ruby
response_body = Resas::Api.client.get( 'prefectures' )
```

以下の (1) - (4) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'prefectures' ) # (1)

# Resas::Api.client.get( ... ) は、 Resas::Api.get( ... ) と記述できる。
response_body = Resas::Api.get( 'prefectures' ) # (2)

# 引数はシンボルでもよい。
response_body = Resas::Api.get( :prefectures ) # (3)

# もっと、シンプルに。
response_body = Resas::Api.prefectures # (4)
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007fa719484af0
  @client=#<Resas::Api::Client:0x007fa7194ad298
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1",
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
#=> #<URI::HTTPS https://opendata.resas-portal.go.jp/api/v1/prefectures>

response_body.path( full: false )
=> #<URI::Generic prefectures>
```

* データ取得前に、アクセスする URL を知りたい（通信なし）

```ruby
Resas::Api.client.path( 'prefectures' )
=> #<URI::HTTPS https://opendata.resas-portal.go.jp/api/v1/prefectures>

Resas::Api.client.path( 'prefectures', full: false )
=> #<URI::Generic prefectures>
```


#### 例2 島根県の市町村一覧を取得する

* 利用するAPI
  * [市区町村一覧](https://opendata.resas-portal.go.jp/docs/api/v1/cities.html)

例1からわかるように、島根県には都道府県コード`'32'`が割り当てられています。

```ruby
response_body = Resas::Api.client.get( 'cities', { 'prefCode' => '32' } )
```

以下の (1) - (9) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'cities', { 'prefCode' => '32' } ) # (1)

# Resas::Api.client.get( ... ) は、 Resas::Api.get( ... ) と記述できる。
response_body = Resas::Api.get( 'cities', { 'prefCode' => '32' } ) # (2)

# 引数はシンボルでもよい。オプションはキーワード引数として記述してもよい。
# オプション、キーワード引数の値は文字列に変換される。
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
    @api_version="v1",
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

#### 例3 島根県の「食料品製造業」について調べる

* 利用するAPI
  * [製造業事業所単位分析_継続・参入・退出事業所別の推移](https://opendata.resas-portal.go.jp/docs/api/v1/industry/power/forManufacturerEstablishments.html)
  * [産業中分類コード](https://opendata.resas-portal.go.jp/docs/api/v1/industries/middle.html)

API [製造業事業所単位分析_継続・参入・退出事業所別の推移](https://opendata.resas-portal.go.jp/docs/api/v1/industry/power/forManufacturerEstablishments.html)を利用します。

##### Step1 産業中分類コードを取得

その前に、[製造業事業所単位分析_継続・参入・退出事業所別の推移](https://opendata.resas-portal.go.jp/docs/api/v1/industry/power/forManufacturerEstablishments.html)で利用する[産業中分類コード](https://opendata.resas-portal.go.jp/docs/api/v1/industries/middle.html)を取得しましょう。

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
    @api_version="v1",
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
  ........ ,
  {"simcCode"=>"09", "sicCode"=>"E", "simcName"=>"食料品製造業"}, # これを使う！
  ........ ,
  {"simcCode"=>"99", "sicCode"=>"T", "simcName"=>"分類不能の産業"}
]
```

##### Step2 「食料品製造業」の推移を取得

「食料品製造業」には、産業大区分コード`'E'`、産業中分類コード`'09'`が割り当てられています。

```ruby
response_body = Resas::Api.client.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => '32', 'sicCode' => 'E', 'simcCode' => '09' } )
```

以下の (1) - (8) はすべて同じ結果となります。

```ruby
response_body = Resas::Api.client.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => '32', 'sicCode' => 'E', 'simcCode' => '09' } ) # (1)

# Resas::Api.client.get( ... ) は、 Resas::Api.get( ... ) と記述できる。
response_body = Resas::Api.get( 'industry/power/forManufacturerEstablishments', { 'prefCode' => '32', 'sicCode' => 'E', 'simcCode' => '09' } ) # (2)

# 'industry/power/forManufacturerEstablishments' は、3つの引数 'industry', 'power', 'forManufacturerEstablishments' に分割できる。
response_body = Resas::Api.get( 'industry', 'power', 'forManufacturerEstablishments', { 'prefCode' => '32', 'sicCode' => 'E', 'simcCode' => '09' } ) # (3)

# 引数はシンボルでもよい。オプションはキーワード引数として記述してもよい。
# オプション、キーワード引数の値は文字列に変換されるので、数値やシンボルを与えてもよい。
# 注意：数値 9 は文字列 '9' （'09'ではない！）に変換される。
response_body = Resas::Api.get( :industry, :power, :forManufacturerEstablishments, prefCode: 32, sicCode: :E, simcCode: '09' ) # (4)

# 引数、オプション、キーワード引数の文字列やシンボルは snake case でもよい。
response_body = Resas::Api.get( 'industry', 'power', 'for_manufacturer_establishments', { 'pref_code' => 32, 'sic_code' => :E, 'simc_code' => '09' } ) # (5)
response_body = Resas::Api.get( :industry, :power, :for_manufacturer_establishments, pref_code: 32, sic_code: :E, simc_code: '09' ) # (6)

# もっと、シンプルに。
response_body = Resas::Api.industry_power_for_manufacturer_establishments( { 'prefCode' => '32', 'sicCode' => 'E', 'simcCode' => '09' } ) # (7)
response_body = Resas::Api.industry_power_for_manufacturer_establishments( pref_code: 32, sic_code: :E, simc_code: '09' ) # (8)
```

* 結果

```ruby
response_body
=> #<Resas::Api::Response::Body:0x007fbce32416a0
  @client=#<Resas::Api::Client:0x007fbce4855b08
    @access_key="[ApiAccessKey]",
    @adapter=:net_http,
    @api_version="v1",
    @base_url="https://opendata.resas-portal.go.jp",
    @format=:json
  >,
 @h={
    "message"=>nil,
    "result"=>{
      "prefCode"=>32,
      "prefName"=>"島根県",
      "sicCode"=>"E",
      "sicName"=>"製造業",
      "simcCode"=>"09",
      "simcName"=>"食料品製造業",
      "establishments"=>[{
        "label"=>"退出",
        "data"=>[
          {"year"=>1990, "value"=>3706.5987, "labor"=>393.858, "employee"=>9.411},
          ........ ,
          {"year"=>2003, "value"=>3876.8193, "labor"=>453.8449, "employee"=>8.5422}
        ]
      }, {
        "label"=>"継続",
        "data"=>[
          {"year"=>1993, "value"=>10957.0909, "labor"=>612.9062, "employee"=>17.8773},
          ........ ,
          {"year"=>1995, "value"=>10498.1781, "labor"=>572.2003, "employee"=>18.347}
        ]
      }, {
        "label"=>"全事業所",
        "data"=>[
          {"year"=>1996, "value"=>7741.3371, "labor"=>549.2498, "employee"=>14.0944},
          ........ ,
          {"year"=>2010, "value"=>8551.9382, "labor"=>467.6197, "employee"=>18.2882}
        ]
      }, {
        "label"=>"参入",
        "data"=>[
          {"year"=>2004, "value"=>7429.9206, "labor"=>393.3487, "employee"=>18.8889},
          ........ ,
          {"year"=>1993, "value"=>5389.1429, "labor"=>457.2606, "employee"=>11.7857}
        ]}
      ]}
    },
  @options={"prefCode"=>"32", "sicCode"=>"E", "simcCode"=>"09"},
  @path="industry/power/forManufacturerEstablishments"
>

response_body.result
=>{
  "message"=>nil,
  "result"=>{
    "prefCode"=>32,
    "prefName"=>"島根県",
    "sicCode"=>"E",
    "sicName"=>"製造業",
    "simcCode"=>"09",
    "simcName"=>"食料品製造業",
    "establishments"=>[{
      "label"=>"退出",
      "data"=>[
        {"year"=>1990, "value"=>3706.5987, "labor"=>393.858, "employee"=>9.411},
        {"year"=>1994, "value"=>4966.2651, "labor"=>507.4843, "employee"=>9.786},
        {"year"=>2005, "value"=>3519.7619, "labor"=>421.5684, "employee"=>8.3492},
        {"year"=>2004, "value"=>3907.0938, "labor"=>454.6436, "employee"=>8.5938},
        {"year"=>1995, "value"=>4296.8667, "labor"=>454.1404, "employee"=>9.4615},
        {"year"=>2002, "value"=>3781.8587, "labor"=>420.7146, "employee"=>8.9891},
        {"year"=>1996, "value"=>4426.2775, "labor"=>452.3012, "employee"=>9.7861},
        {"year"=>2001, "value"=>3958.0097, "labor"=>422.4611, "employee"=>9.3689},
        {"year"=>1997, "value"=>4551.9608, "labor"=>462.1433, "employee"=>9.8497},
        {"year"=>2000, "value"=>4779.2613, "labor"=>514.547, "employee"=>9.2883},
        {"year"=>1998, "value"=>5062.7655, "labor"=>533.8916, "employee"=>9.4828},
        {"year"=>2008, "value"=>3212.8095, "labor"=>527.1016, "employee"=>6.0952},
        {"year"=>2006, "value"=>3786.2857, "labor"=>436.8791, "employee"=>8.6667},
        {"year"=>1993, "value"=>4540.6738, "labor"=>473.3678, "employee"=>9.5923},
        {"year"=>1991, "value"=>4185.6109, "labor"=>427.2049, "employee"=>9.7977},
        {"year"=>2009, "value"=>3872.5, "labor"=>545.4225, "employee"=>7.1},
        {"year"=>1999, "value"=>4794.9762, "labor"=>486.8388, "employee"=>9.8492},
        {"year"=>1992, "value"=>4468.1883, "labor"=>448.5078, "employee"=>9.9623},
        {"year"=>2007, "value"=>3066.5143, "labor"=>417.6187, "employee"=>7.3429},
        {"year"=>2003, "value"=>3876.8193, "labor"=>453.8449, "employee"=>8.5422}
      ]
    }, {
     "label"=>"継続",
     "data"=>[
       {"year"=>1993, "value"=>10957.0909, "labor"=>612.9062, "employee"=>17.8773},
       {"year"=>2004, "value"=>9540.1244, "labor"=>501.2608, "employee"=>19.0323},
       {"year"=>1992, "value"=>9444.8303, "labor"=>545.5678, "employee"=>17.3119},
       {"year"=>2006, "value"=>8930.6637, "labor"=>493.8106, "employee"=>18.0852},
       {"year"=>2000, "value"=>10324.148, "labor"=>567.0653, "employee"=>18.2063},
       {"year"=>2010, "value"=>9271.5605, "labor"=>511.0129, "employee"=>18.1435},
       {"year"=>2005, "value"=>9133.3468, "labor"=>498.6727, "employee"=>18.3153},
       {"year"=>1991, "value"=>8881.3488, "labor"=>510.9687, "employee"=>17.3814},
       {"year"=>2008, "value"=>9143.7297, "labor"=>497.8926, "employee"=>18.3649},
       {"year"=>2007, "value"=>9421.473, "labor"=>517.8428, "employee"=>18.1937},
       {"year"=>2009, "value"=>9347.435, "labor"=>515.0675, "employee"=>18.148},
       {"year"=>1990, "value"=>8934.0045, "labor"=>523.4585, "employee"=>17.0673},
       {"year"=>1994, "value"=>10151.2037, "labor"=>554.2619, "employee"=>18.3148},
       {"year"=>2003, "value"=>8999.1171, "labor"=>485.6111, "employee"=>18.5315},
       {"year"=>1999, "value"=>10057.509, "labor"=>543.5168, "employee"=>18.5045},
       {"year"=>1998, "value"=>10467.1318, "labor"=>574.1134, "employee"=>18.2318},
       {"year"=>1996, "value"=>10972.9682, "labor"=>595.6213, "employee"=>18.4227},
       {"year"=>1997, "value"=>10794.6909, "labor"=>587.2483, "employee"=>18.3818},
       {"year"=>2002, "value"=>9670.7557, "labor"=>513.6354, "employee"=>18.8281},
       {"year"=>2001, "value"=>10338.9682, "labor"=>544.9384, "employee"=>18.9727},
       {"year"=>1995, "value"=>10498.1781, "labor"=>572.2003, "employee"=>18.347}
      ]
    }, {
      "label"=>"全事業所",
      "data"=>[
        {"year"=>1996, "value"=>7741.3371, "labor"=>549.2498, "employee"=>14.0944},
        {"year"=>1999, "value"=>7772.3951, "labor"=>511.5371, "employee"=>15.1942},
        {"year"=>2008, "value"=>7797.6194, "labor"=>480.727, "employee"=>16.2205},
        {"year"=>2003, "value"=>7041.5593, "labor"=>447.2034, "employee"=>15.7458},
        {"year"=>1990, "value"=>5897.7857, "labor"=>467.3253, "employee"=>12.6203},
        {"year"=>1997, "value"=>7912.8222, "labor"=>536.0219, "employee"=>14.7621},
        {"year"=>2009, "value"=>8099.3863, "labor"=>461.7738, "employee"=>17.5397},
        {"year"=>1998, "value"=>7844.4052, "labor"=>544.4733, "employee"=>14.4073},
        {"year"=>2007, "value"=>8048.6395, "labor"=>490.692, "employee"=>16.4026},
        {"year"=>2000, "value"=>7654.6948, "labor"=>510.7008, "employee"=>14.9886},
        {"year"=>1994, "value"=>7288.1754, "labor"=>531.6029, "employee"=>13.7098},
        {"year"=>1992, "value"=>6697.7254, "labor"=>502.6126, "employee"=>13.3258},
        {"year"=>2002, "value"=>7519.0388, "labor"=>473.7489, "employee"=>15.8714},
        {"year"=>2004, "value"=>7772.2214, "labor"=>468.9712, "employee"=>16.5729},
        {"year"=>1993, "value"=>7321.8896, "labor"=>554.6549, "employee"=>13.2008},
        {"year"=>2005, "value"=>7282.685, "labor"=>462.3927, "employee"=>15.75},
        {"year"=>1995, "value"=>7170.8611, "labor"=>525.6834, "employee"=>13.641},
        {"year"=>2001, "value"=>7868.7874, "labor"=>496.7317, "employee"=>15.8411},
        {"year"=>2006, "value"=>7555.815, "labor"=>453.5435, "employee"=>16.6595},
        {"year"=>1991, "value"=>6135.7968, "labor"=>473.4499, "employee"=>12.9598},
        {"year"=>2010, "value"=>8551.9382, "labor"=>467.6197, "employee"=>18.2882}
      ]
    }, {
      "label"=>"参入",
      "data"=>[
        {"year"=>2004, "value"=>7429.9206, "labor"=>393.3487, "employee"=>18.8889},
        {"year"=>2010, "value"=>7180.3504, "labor"=>386.7868, "employee"=>18.5641},
        {"year"=>1999, "value"=>8308.0233, "labor"=>454.5102, "employee"=>18.2791},
        {"year"=>2009, "value"=>6954.1416, "labor"=>374.7344, "employee"=>18.5575},
        {"year"=>2000, "value"=>6940.0816, "labor"=>386.4364, "employee"=>17.9592},
        {"year"=>2005, "value"=>7362.7571, "labor"=>397.3732, "employee"=>18.5286},
        {"year"=>1995, "value"=>4841.1111, "labor"=>444.5918, "employee"=>10.8889},
        {"year"=>2001, "value"=>8166.2778, "labor"=>418.7835, "employee"=>19.5},
        {"year"=>2006, "value"=>7572.0519, "labor"=>414.0966, "employee"=>18.2857},
        {"year"=>2007, "value"=>7418.3404, "labor"=>441.3443, "employee"=>16.8085},
        {"year"=>2002, "value"=>7901.6727, "labor"=>415.8775, "employee"=>19},
        {"year"=>2003, "value"=>6858.8413, "labor"=>372.506, "employee"=>18.4127},
        {"year"=>2008, "value"=>8040.9684, "labor"=>466.072, "employee"=>17.2526},
        {"year"=>1992, "value"=>6402, "labor"=>447.6923, "employee"=>14.3},
        {"year"=>1991, "value"=>4950.625, "labor"=>488.9506, "employee"=>10.125},
        {"year"=>1997, "value"=>8805.0435, "labor"=>387.9617, "employee"=>22.6957},
        {"year"=>1996, "value"=>5630.5556, "labor"=>504.2289, "employee"=>11.1667},
        {"year"=>1994, "value"=>5465.1765, "labor"=>462.2289, "employee"=>11.8235},
        {"year"=>1998, "value"=>8227.3659, "labor"=>464.6309, "employee"=>17.7073},
        {"year"=>1993, "value"=>5389.1429, "labor"=>457.2606, "employee"=>11.7857}
      ]
    }]
  }
}
```
