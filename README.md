# Resas::Api

Resas::Api は、[RESAS](https://resas.go.jp/) (Regional Economy Society Analyzing System) をRubyで扱いやすくするための Gem です。

## Installation

Gem 内部で Resas::Api を使用する場合は、Gemfileに

```ruby
gem 'resas-api'
```

を指定してください。

また、環境変数 RESAS_API_ACCESS_KEY に、[https://opendata.resas-portal.go.jp/form.html](https://opendata.resas-portal.go.jp/form.html) より取得したAPIキーを指定してください。

## Usage

### Example

```ruby
require 'resas/api' #=> true
client = Resas::Api::Client.instance
#=> #<Resas::Api::Client:0x007fecf700d980
 @header={"X-API-KEY"=>"[Your API Key]", "Content-Type"=>"application/json"},
 @http=#<Net::HTTP opendata.resas-portal.go.jp:443 open=false>>
res = client.get( 'industry', 'patent', 'list', {year: 2014, mode: 1, pref_code:13,city_code: '-', patent_holder_id: 'C34987964', sort1:3, sort2: 1, offset: 0} )
#=> #<Net::HTTPOK 200 OK readbody=true>
res.body
#=>
```

## Contributing

バグの報告、プルリクエストは[GitHub nard-tech/resas-api](https://github.com/nard-tech/resas-api)へどうぞ。

Bug reports and pull requests are welcome on GitHub at https://github.com/nard-tech/resas-api.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

このGemは[MITライセンス](http://opensource.org/licenses/MIT)で公開されています。
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
