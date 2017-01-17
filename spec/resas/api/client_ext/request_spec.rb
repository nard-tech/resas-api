require 'spec_helper'

describe Resas::Api::Client do

  describe 'defined in Resas::Api::ClientExt::Request' do

    before do
      @client = Resas::Api.client
    end

    it 'has instance method \'#path\'' do
      expect( @client ).to respond_to( :path )
    end

    describe '#path' do

      it 'returns path for the API' do
        expect( @client.path( 'cities' ) ).to be_present
        expect( @client.path( 'cities' ) ).to be_instance_of( URI::HTTPS )
        expect( @client.path( 'cities' ).to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities' )

        expect( @client.path( 'cities', pref_code: 1 ) ).to be_present
        expect( @client.path( 'cities', pref_code: 1 ) ).to be_instance_of( URI::HTTPS )
        expect( @client.path( 'cities', pref_code: 1 ).to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=1' )

        expect( @client.path( 'cities', pref_code: 1, full: true ) ).to be_present
        expect( @client.path( 'cities', pref_code: 1, full: true ) ).to be_instance_of( URI::HTTPS )
        expect( @client.path( 'cities', pref_code: 1, full: true ).to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=1' )

        expect( @client.path( 'cities', pref_code: 1, full: false ) ).to be_present
        expect( @client.path( 'cities', pref_code: 1, full: false ) ).to be_instance_of( URI::Generic )
        expect( @client.path( 'cities', pref_code: 1, full: false ).to_s ).to eq( 'cities?prefCode=1' )
      end

    end

  end

end
