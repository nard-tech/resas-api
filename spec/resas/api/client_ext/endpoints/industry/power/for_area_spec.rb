require 'spec_helper'

__END__

xdescribe Resas::Api::ClientExt::Endpoints do

  # @see {https://opendata.resas-portal.go.jp/docs/api/v1/industry/power/forArea.html}
  describe 'industry/power/forArea' do

    industries_broad = Resas::Api.client.get( :industries, :broad ).result
    cities = Resas::Api.client.get( :cities ).result

    prefectures = [ 1, nil ]
    year = 2012
    area_types = {
      1 => '全国の分布を見る',
      2  => '都道府県内の分布を見る',
    }
    display_types = {
      1 => '特化係数（付加価値額）',
      2 => '特化係数（労働生産性）',
      3 => '特化係数（従業者数）',
    }

    industries_broad.each do | industry_broad |
      sic_code = industry_broad[ 'sicCode' ]
      sic_name = industry_broad[ 'sicName' ]

      prefectures.each do | pref |
        context "都道府県: #{ pref.to_s }" do

          context "産業大分類 #{ sic_code }（#{ sic_name }）" do

            area_types.each do | area_type_num, area_type_name |
              context " > 表示方法 #{ area_type_num }（#{ area_type_name }）" do

                display_types.each do | display_type_num, display_type_name |
                  context " > 表示内容 #{ display_type_num }（#{ display_type_name }）" do

                    response = Resas::Api.get(
                      :industry,
                      :power,
                      :for_area,
                      year: year,
                      area_type: area_type_num,
                      disp_type: display_type_num,
                      pref_code: pref,
                      sic_code: sic_code
                    )

                    sleep(0.5)

                    context response.path do
                      it 'has result.' do
                        expect( response.result ).to be_present
                      end

                      case area_type_num
                      when 1
                        it 'has infos for prefectures' do
                          expect( response.result[ 'prefectures' ] ).to be_present
                          expect( response.result[ 'prefectures' ] ).to be_instance_of( Array )
                          expect( response.result[ 'prefectures' ].length ).to eq(47)
                          expect( response.result[ 'prefectures' ] ).to all( be_present )
                          expect( response.result[ 'prefectures' ] ).to all( be_instance_of( Hash ) )
                        end
                      when 2
                        it 'does not have infos for prefectures' do
                          expect( response.result[ 'prefectures' ] ).not_to be_present
                          expect( response.result[ 'prefectures' ] ).to be_nil
                        end
                      end

                      it 'has infos for cities' do
                        expect( response.result[ 'cities' ] ).to be_present
                        expect( response.result[ 'cities' ] ).to be_instance_of( Array )
                        expect( response.result[ 'cities' ] ).to all( be_present )
                        expect( response.result[ 'cities' ] ).to all( be_instance_of( Hash ) )
                      end

                      context 'cities' do
                        condition = response.result[ 'cities' ].all? { | industry_info_for_city | industry_info_for_city.instance_of?( Hash ) }
                        if condition
                          response.result[ 'cities' ].each do | industry_info_for_city |
                            city_info = cities.find { | city |
                              city[ 'cityCode' ] == industry_info_for_city[ 'cityCode' ] && city[ 'cityName' ] == industry_info_for_city[ 'cityName' ]
                            }
                            it "is valid industry info for city '#{ industry_info_for_city[ 'cityName' ] }'." do
                              expect( city_info ).to be_present
                            end
                          end
                        end

                        if pref.nil?
                          condition = response.result[ 'cities' ].all? { | industry_info_for_city | industry_info_for_city.instance_of?( Hash ) }
                          if condition
                            cities.each do | city |
                              industry_info_for_city = response.result[ 'cities' ].find { | industry_info_for_city |
                                city[ 'cityCode' ] == industry_info_for_city[ 'cityCode' ] && city[ 'cityName' ] == industry_info_for_city[ 'cityName' ]
                              }
                              it "has valid industry info for #{ city[ 'cityName' ] }." do
                                expect( industry_info_for_city ).to be_present
                              end
                            end
                          end
                        end
                      end

                    end

                  end
                end

              end
            end

          end

        end
      end
    end
  end
end
