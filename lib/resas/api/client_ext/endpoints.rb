# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
# @see {https://opendata.resas-portal.go.jp/}
# @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  module Api

    module ClientExt

      # 各 API のエンドポイントに直接アクセスするためのメソッドを格納するモジュール
      # @see API概要 > 一覧 (https://opendata.resas-portal.go.jp/docs/api/v1/index.html)
      module Endpoints

        # @!group 共通 > 都道府県、市区町村

        # 都道府県一覧 (prefectures)
        def prefectures( params = {} )
          get( 'prefectures', params )
        end

        # 市区町村一覧 (cities)
        def cities( params = {} )
          get( 'cities', params )
        end

        # 旧市区町村一覧 (oldCities)
        def old_cities( params = {} )
          get( 'oldCities', params )
        end

        # @!group 共通 > 産業 (industries)

        # 産業大分類 (industries/broad)
        def industries_broad( params = {} )
          get( 'industries/broad', params )
        end

        # 産業中分類 (industries/middle)
        def industries_middle( params = {} )
          get( 'industries/middle', params )
        end

        # 産業小分類 (industries/narrow)
        def industries_narrow( params = {} )
          get( 'industries/narrow', params )
        end

        # @!group 共通 > 職業 (jobs)

        # 職業大分類 (jobs/broad)
        def jobs_broad( params = {} )
          get( 'jobs/broad', params )
        end

        # 職業中分類 (jobs/middle)
        def jobs_middle( params = {} )
          get( 'jobs/middle', params )
        end

        # @!group 共通 > 特許 (patents)

        # 特許 技術分野 (patents/broad)
        def patents_broad( params = {} )
          get( 'patents/broad', params )
        end

        # 特許 技術テーマ (patents/middle)
        def patents_middle( params = {} )
          get( 'patents/middle', params )
        end

        # 特許権者の所在地 (patents/locations)
        def patents_locations( params = {} )
          get( 'patents/locations', params )
        end

        # @!group 共通 > 世界の地域・国 (regions)

        # 取引地域 (regions/broad)
        def regions_broad( params = {} )
          get( 'regions/broad', params )
        end

        # 取引国 (regions/middle)
        def regions_middle( params = {} )
          get( 'regions/middle', params )
        end

        # @!group 共通 > 輸出入花火図 (tradeInfoItemTypes)

        # 品目 大分類 (tradeInfoItemTypes/broad)
        def trade_info_item_types_broad( params = {} )
          get( 'tradeInfoItemTypes/broad', params )
        end

        # 品目 中分類 (tradeInfoItemTypes/middle)
        def trade_info_item_types_middle( params = {} )
          get( 'tradeInfoItemTypes/middle', params )
        end

        # 品目 小分類 (tradeInfoItemTypes/narrow)
        def trade_info_item_types_narrow( params = {} )
          get( 'tradeInfoItemTypes/narrow', params )
        end

        # @!group 共通 > その他

        # 税関 (customs)
        def customs( params = {} )
          get( 'customs', params )
        end

        # 農業部門 (regions/agricultureDepartments)
        def regions_agriculture_departments( params = {} )
          get( 'regions/agricultureDepartments', params )
        end

        # @!group 産業 (industry)

        # 特許一覧 (industry/patent/list)
        def industry_patent_list( params = {} )
          get( 'industry/patent/list', params )
        end

        # 国、税関別輸出入 (industry/export/fromTo)
        def industry_export_from_to( params = {} )
          get( 'industry/export/fromTo', params )
        end

        # 海外への企業進出動向向 (industry/globalmarket/perPref)
        def industry_global_market_per_pref( params = {} )
          get( 'industry/globalmarket/perPref', params )
        end

        # 産業別特化係数 (industry/power/forIndustry)
        def industry_power_for_industry( params = {} )
          get( 'industry/power/forIndustry', params )
        end

        # 地域別特化係数 (industry/power/forArea)
        def industry_power_for_area( params = {} )
          get( 'industry/power/forArea', params )
        end

        # 製造業事業所単位分析_継続・参入・退出事業所別の推移 (industry/power/forManufacturerEstablishments)
        def industry_power_for_manufacturer_establishments( params = {} )
          get( 'industry/power/forManufacturerEstablishments', params )
        end

        # @!group 農林水産業 > 農業 (agriculture)

        # 農産物の出荷先別販売金額構成 (agriculture/sales/shipValue)
        def agriculture_sales_ship_value( params = {} )
          get( 'agriculture/sales/shipValue', params )
        end

        # 農産物の出荷先別経営体数割合 (agriculture/sales/shipRatio)
        def agriculture_sales_ship_ratio( params = {} )
          get( 'agriculture/sales/shipRatio', params )
        end

        # 経営耕地面積 (agriculture/land/forStacked)
        def agriculture_land_for_stacked( params = {} )
          get( 'agriculture/land/forStacked', params )
        end

        # 経営耕地面積規模別の経営体割合 (agriculture/land/Ratio)
        def agriculture_land_ratio( params = {} )
          get( 'agriculture/land/Ratio', params )
        end

        # 農地流動化率 (agriculture/land/forMobility)
        def agriculture_land_for_mobility( params = {} )
          get( 'agriculture/land/forMobility', params )
        end

        # 耕作放棄地率 (agriculture/land/forAbandonment)
        def agriculture_land_for_abandonment( params = {} )
          get( 'agriculture/land/forAbandonment', params )
        end

        # 農業部門別販売金額 (agriculture/all/forStacked)
        def agriculture_all_for_stacked( params = {} )
          get( 'agriculture/all/forStacked', params )
        end

        # 年間延べ農作業日数 (agriculture/crops/workingDays)
        def agriculture_crops_working_days( params = {} )
          get( 'agriculture/crops/workingDays', params )
        end

        # 農産物販売金額（人日あたり） (agriculture/crops/sales)
        def agriculture_crops_sales( params = {} )
          get( 'agriculture/crops/sales', params )
        end

        # 農業経営者・農業就業人口の年齢構成 (agriculture/crops/farmersAgeStructure)
        def agriculture_crops_farmers_age_structure( params = {} )
          get( 'agriculture/crops/farmersAgeStructure', params )
        end

        # 農業経営者・農業就業人口の平均年齢 (agriculture/crops/farmersAverageAge)
        def agriculture_crops_farmers_average_age( params = {} )
          get( 'agriculture/crops/farmersAverageAge', params )
        end

        # 農業生産関連事業の実施状況（経営体数） (agriculture/crops/relatedBusiness)
        def agriculture_crops_related_business( params = {} )
          get( 'agriculture/crops/relatedBusiness', params )
        end

        # 農業経営体の法人化率 (agriculture/crops/averageOfCorporate)
        def agriculture_crops_average_of_corporate( params = {} )
          get( 'agriculture/crops/averageOfCorporate', params )
        end

        # @!group 農林水産業 > 林業 (forestry)

        # 林業総収入（総額） (forestry/income/forStacked)
        def forestry_income_for_stacked( params = {} )
          get( 'forestry/income/forStacked', params )
        end

        # 林産物販売金額（経営体あたり） (forestry/income/forSales)
        def forestry_income_for_sales( params = {} )
          get( 'forestry/income/forSales', params )
        end

        # 林作業請負収入（経営体あたり） (forestry/income/forContractRevenue)
        def forestry_income_for_contract_revenue( params = {} )
          get( 'forestry/income/forContractRevenue', params )
        end

        # 林産物販売金額帯別の経営体割合 (forestry/income/forSalesRatio)
        def forestry_income_for_sales_ratio( params = {} )
          get( 'forestry/income/forSalesRatio', params )
        end

        # 林作業請負収入金額帯別の経営体割合 (forestry/income/forContractRevenueRatio)
        def forestry_income_for_contract_revenue_ratio( params = {} )
          get( 'forestry/income/forContractRevenueRatio', params )
        end

        # 主要林業部門別延べ経営体数 (forestry/income/allPortfolio)
        def forestry_income_all_portfolio( params = {} )
          get( 'forestry/income/allPortfolio', params )
        end

        # 主要林業部門別延べ経営体数構成 (forestry/income/allForStacked)
        def forestry_income_all_for_stacked( params = {} )
          get( 'forestry/income/allForStacked', params )
        end

        # @!group 農林水産業 > 水産業 (fishery)

        # 主要海面漁業種類別延べ経営体数構成 (fishery/sea/staple)
        def fishery_sea_staple( params = {} )
          get( 'fishery/sea/staple', params )
        end

        # 海面漁獲物等販売金額（総額） (fishery/sea/totalSales)
        def fishery_sea_total_sales( params = {} )
          get( 'fishery/sea/totalSales', params )
        end

        # 海面漁獲物等販売金額（経営体あたり） (fishery/sea/managementUnitSales)
        def fishery_sea_management_unit_sales( params = {} )
          get( 'fishery/sea/managementUnitSales', params )
        end

        # 海面漁獲物等販売金額帯別の経営体割合 (fishery/sea/sales)
        def fishery_sea_sales( params = {} )
          get( 'fishery/sea/sales', params )
        end

        # 海面漁獲物等出荷先別販売金額構成 (fishery/sea/shipValue)
        def fishery_sea_ship_value( params = {} )
          get( 'fishery/sea/shipValue', params )
        end

        # 海面漁獲物等出荷先別経営体数割合 (fishery/sea/shipRatio)
        def fishery_sea_ship_ratio( params = {} )
          get( 'fishery/sea/shipRatio', params )
        end

        # 海面養殖販売金額（総額） (fishery/sea/aquacultureTotalSales)
        def fishery_sea_aquaculture_total_sales( params = {} )
          get( 'fishery/sea/aquacultureTotalSales', params )
        end

        # 海面養殖販売金額（経営体あたり） (fishery/sea/aquacultureManagementUnitSales)
        def fishery_sea_aquaculture_management_unit_sales( params = {} )
          get( 'fishery/sea/aquacultureManagementUnitSales', params )
        end

        # 海面養殖販売金額帯別の経営体割合 (fishery/sea/aquacultureSales)
        def fishery_sea_aquaculture_sales( params = {} )
          get( 'fishery/sea/aquacultureSales', params )
        end

        # @!group 観光 (tourism)

        # 指定地域への国籍別訪問者数 (tourism/foreigners/forFrom)
        def tourism_foreigners_for_from( params = {} )
          get( 'tourism/foreigners/forFrom', params )
        end

        # 指定国籍からの訪問者数 (tourism/foreigners/forTo)
        def tourism_foreigners_for_to( params = {} )
          get( 'tourism/foreigners/forTo', params )
        end

        # @!group 人口 (population)

        # 人口の自然増減 (population/nature)
        def population_nature( params = {} )
          get( 'population/nature', params )
        end

        # 人口構成 (population/composition/perYear)
        def population_composition_per_year( params = {} )
          get( 'population/composition/perYear', params )
        end

        # 人口ピラミッド (population/composition/pyramid)
        def population_composition_pyramid( params = {} )
          get( 'population/composition/pyramid', params )
        end

        # 人口増減率 (population/sum/perYear)
        def population_sum_per_year( params = {} )
          get( 'population/sum/perYear', params )
        end

        # 出生数・死亡数／転入数・転出数 (population/sum/estimate)
        def population_sum_estimate( params = {} )
          get( 'population/sum/estimate', params )
        end

        # 将来人口推計 (population/future/cities)
        def population_future_cities( params = {} )
          get( 'population/future/cities', params )
        end

        # @!group 自治体比較 (municipality)

        # 企業数 (municipality/company/perYear)
        def municipality_company_per_year( params = {} )
          get( 'municipality/company/perYear', params )
        end

        # 事業所数 (municipality/plant/perYear)
        def municipality_plant_per_year( params = {} )
          get( 'municipality/plant/perYear', params )
        end

        # 創業比率 (municipality/foundation/perYear)
        def municipality_foundation_per_year( params = {} )
          get( 'municipality/foundation/perYear', params )
        end

        # 一人当たり地方税 (municipality/taxes/perYear)
        def municipality_taxes_per_year( params = {} )
          get( 'municipality/taxes/perYear', params )
        end

        # 有効求人倍率 (municipality/job/perYear)
        def municipality_job_per_year( params = {} )
          get( 'municipality/job/perYear', params )
        end

        # 製造品出荷額 (municipality/manufacture/perYear)
        def municipality_manufacture_per_year( params = {} )
          get( 'municipality/manufacture/perYear', params )
        end

        # 従業者数（事業所単位） (municipality/employee/perYear)
        def municipality_employee_per_year( params = {} )
          get( 'municipality/employee/perYear', params )
        end

        # 付加価値額（企業単位） (municipality/value/perYear)
        def municipality_value_per_year( params = {} )
          get( 'municipality/value/perYear', params )
        end

        # 労働生産性（企業単位） (municipality/labor/perYear)
        def municipality_labor_per_year( params = {} )
          get( 'municipality/labor/perYear', params )
        end

        # 黒字赤字企業比率 (municipality/surplus/perYear)
        def municipality_surplus_per_year( params = {} )
          get( 'municipality/surplus/perYear', params )
        end

        # 一人当たり賃金 (municipality/wages/perYear)
        def municipality_wages_per_year( params = {} )
          get( 'municipality/wages/perYear', params )
        end

        # 年間商品販売額 (municipality/sales/perYear)
        def municipality_sales_per_year( params = {} )
          get( 'municipality/sales/perYear', params )
        end

        # @!endgroup

      end
    end
  end
end
