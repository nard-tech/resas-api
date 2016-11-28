require 'spec_helper'

describe Resas::Api::Client::Util::PathSettingsNormalizer do

  describe 'API: prefectures' do

    args = [
      'prefectures',
      [ 'prefectures' ],
      :prefectures,
      [ :prefectures ],
    ]

    it 'containts instance variable \'@path\' and \'@options\'' do

      args.each do | arg |
        normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

        expect( normalizer.path ).to be_instance_of( String )
        expect( normalizer.options ).to be_instance_of( Hash )
      end

      args.each do | arg |
        normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

        expect( normalizer.path ).to eq( 'prefectures' )
        expect( normalizer.options ).to eq( {} )
      end

    end

  end

  describe 'API: cities' do

    args = [
      'cities',
      :cities,
      [ 'cities' ],
      [ :cities ],
    ]

    describe 'without option' do

      it 'containts instance variable \'@path\' and \'@options\'' do

        args.each do | arg |
          normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

          expect( normalizer.path ).to be_instance_of( String )
          expect( normalizer.options ).to be_instance_of( Hash )

          expect( normalizer.path ).to eq( 'cities' )
          expect( normalizer.options ).to eq( {} )
        end

        args.each do | arg |
          normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg, {} )

          expect( normalizer.path ).to be_instance_of( String )
          expect( normalizer.options ).to be_instance_of( Hash )

          expect( normalizer.path ).to eq( 'cities' )
          expect( normalizer.options ).to eq( {} )
        end

      end

    end

    describe 'with options' do

      options = [
        { pref_code: 1 },
        { prefCode: 1 },
        { 'pref_code' => 1 },
        { 'prefCode' => 1 },
      ]

      it 'containts instance variable \'@path\' and \'@options\'' do
        args.each do | arg |
          options.each do | option |
            normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg, option )

            expect( normalizer.path ).to be_instance_of( String )
            expect( normalizer.options ).to be_instance_of( Hash )

            expect( normalizer.path ).to eq( 'cities' )
            expect( normalizer.options ).to eq( { 'prefCode' => '1' } )
          end
        end
      end

    end

  end

  describe 'API: industries/broad' do

    args = [
      'industries/broad',
      [ 'industries/broad' ],
      [ 'industries', 'broad' ],
      [ :industries, :broad ],
    ]

    describe 'without option' do

      it 'containts instance variable \'@path\' and \'@options\'' do

        args.each do | arg |
          normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

          expect( normalizer.path ).to be_instance_of( String )
          expect( normalizer.options ).to be_instance_of( Hash )

          expect( normalizer.path ).to eq( 'industries/broad' )
          expect( normalizer.options ).to eq( {} )
        end

        args.each do | arg |
          normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg, {} )

          expect( normalizer.path ).to be_instance_of( String )
          expect( normalizer.options ).to be_instance_of( Hash )

          expect( normalizer.path ).to eq( 'industries/broad' )
          expect( normalizer.options ).to eq( {} )
        end

      end

    end

    describe 'with options' do

      options = [
        { pref_code: 1 },
        { prefCode: 1 },
        { 'pref_code' => 1 },
        { 'prefCode' => 1 },
      ]

      it 'containts instance variable \'@path\' and \'@options\'' do
        args.each do | arg |
          options.each do | option |
            normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg, option )

            expect( normalizer.path ).to be_instance_of( String )
            expect( normalizer.options ).to be_instance_of( Hash )

            expect( normalizer.path ).to eq( 'industries/broad' )
            expect( normalizer.options ).to eq( { 'prefCode' => '1' } )
          end
        end
      end

    end

  end

  describe 'API: tradeInfoItemTypes/broad' do

    args = [
      'tradeInfoItemTypes/broad',
      [ 'tradeInfoItemTypes/broad' ],
      [ 'tradeInfoItemTypes', 'broad' ],

      'trade_info_item_types/broad',
      [ 'trade_info_item_types/broad' ],
      [ 'trade_info_item_types', 'broad' ],

      [ :tradeInfoItemTypes, :broad ],
      [ :trade_info_item_types, :broad ],
    ]

    it 'containts instance variable \'@path\' and \'@options\'' do

      args.each do | arg |
        normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

        expect( normalizer.path ).to be_instance_of( String )
        expect( normalizer.options ).to be_instance_of( Hash )
      end

      args.each do | arg |
        normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

        expect( normalizer.path ).to eq( 'tradeInfoItemTypes/broad' )
        expect( normalizer.options ).to eq( {} )
      end

    end

  end

  describe 'API: industry/power/forArea' do

    args = [
      'industry/power/forArea',
      [ 'industry/power/forArea' ],
      [ 'industry', 'power', 'forArea' ],

      'industry/power/for_area',
      [ 'industry/power/for_area' ],
      [ 'industry', 'power', 'for_area' ],

      [ :industry, :power, :forArea ],
      [ :industry, :power, :for_area ],
    ]

    describe 'without option' do

      it 'containts instance variable \'@path\' and \'@options\'' do

        args.each do | arg |
          normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg )

          expect( normalizer.path ).to be_instance_of( String )
          expect( normalizer.options ).to be_instance_of( Hash )

          expect( normalizer.path ).to eq( 'industry/power/forArea' )
          expect( normalizer.options ).to eq( {} )
        end

        args.each do | arg |
          normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg, {} )

          expect( normalizer.path ).to be_instance_of( String )
          expect( normalizer.options ).to be_instance_of( Hash )

          expect( normalizer.path ).to eq( 'industry/power/forArea' )
          expect( normalizer.options ).to eq( {} )
        end

      end

    end

    describe 'with options' do

      options = [
        { pref_code: 1 },
        { prefCode: 1 },
        { 'pref_code' => 1 },
        { 'prefCode' => 1 },
      ]

      it 'containts instance variable \'@path\' and \'@options\'' do
        args.each do | arg |
          options.each do | option |
            normalizer = Resas::Api::Client::Util::PathSettingsNormalizer.new( arg, option )

            expect( normalizer.path ).to be_instance_of( String )
            expect( normalizer.options ).to be_instance_of( Hash )

            expect( normalizer.path ).to eq( 'industry/power/forArea' )
            expect( normalizer.options ).to eq( { 'prefCode' => '1' } )
          end
        end
      end

    end

  end

end
