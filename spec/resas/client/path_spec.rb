require "spec_helper"

describe Resas::Api::Client::Path do

  let( :api_version ) { Resas::Api.api_version }

  describe '.#get' do

    let( :result ) { Resas::Api::Client::Path.get( api_version, 'prefectures' ) }

    it 'returns pathname.' do
      expect( result ).to eq( '/api/v1-rc.1/prefectures' )
    end

  end

  describe '#initialize' do

    let( :sample_1 ) { Resas::Api::Client::Path.new( api_version, 'prefectures', {} ) }
    let( :sample_2a ) { Resas::Api::Client::Path.new( api_version, 'industries/broad', {} ) }
    let( :sample_2b ) { Resas::Api::Client::Path.new( api_version, 'industries', 'broad', {} ) }

    let( :sample_3a ) { Resas::Api::Client::Path.new( api_version, 'tradeInfoItemTypes/broad', {} ) }
    let( :sample_3b ) { Resas::Api::Client::Path.new( api_version, 'trade_info_item_types/broad', {} ) }
    let( :sample_3c ) { Resas::Api::Client::Path.new( api_version, 'tradeInfoItemTypes', 'broad', {} ) }
    let( :sample_3d ) { Resas::Api::Client::Path.new( api_version, 'trade_info_item_types', 'broad', {} ) }

    it "has instance variable \'@namespaces\'."  do
      expect( sample_1.instance_variable_get( :@namespaces ) ).to eq( [ 'prefectures' ] )
      expect( sample_2a.instance_variable_get( :@namespaces ) ).to eq( [ 'industries', 'broad' ] )
      expect( sample_2b.instance_variable_get( :@namespaces ) ).to eq( [ 'industries', 'broad' ] )
      expect( sample_3a.instance_variable_get( :@namespaces ) ).to eq( [ 'tradeInfoItemTypes', 'broad' ] )
      expect( sample_3b.instance_variable_get( :@namespaces ) ).to eq( [ 'tradeInfoItemTypes', 'broad' ] )
      expect( sample_3c.instance_variable_get( :@namespaces ) ).to eq( [ 'tradeInfoItemTypes', 'broad' ] )
      expect( sample_3d.instance_variable_get( :@namespaces ) ).to eq( [ 'tradeInfoItemTypes', 'broad' ] )
    end

    it "has instance variable \'@options\'." do
      expect( sample_1.instance_variable_get( :@options ) ).to eq( {} )
      expect( sample_2a.instance_variable_get( :@options ) ).to eq( {} )
      expect( sample_2b.instance_variable_get( :@options ) ).to eq( {} )
      expect( sample_3a.instance_variable_get( :@options ) ).to eq( {} )
      expect( sample_3b.instance_variable_get( :@options ) ).to eq( {} )
      expect( sample_3c.instance_variable_get( :@options ) ).to eq( {} )
      expect( sample_3d.instance_variable_get( :@options ) ).to eq( {} )
    end
  end

  # it "does something useful" do
  #   expect(false).to eq(true)
  # end
end
