require 'spec_helper'

describe Resas::Api::Response::Body do

  describe 'sample \'cities\'' do

    before do
      @body = Resas::Api.client.get( 'cities' )
    end

    it 'is an instance of Resas::Api::Response::Body' do
      expect( @body ).to be_instance_of( Resas::Api::Response::Body )
    end

    it 'has instance method \'#path\'' do
      expect( @body ).to respond_to( :path )
    end

    describe '#path' do

      it 'returns path for cities on the API' do
        expect( @body.path ).to be_present
        expect( @body.path ).to be_instance_of( URI::HTTPS )
        expect( @body.path.to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities' )

        expect( @body.path( full: true ) ).to be_present
        expect( @body.path( full: true ) ).to be_instance_of( URI::HTTPS )
        expect( @body.path( full: true ).to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities' )

        expect( @body.path( full: false ) ).to be_present
        expect( @body.path( full: false ) ).to be_instance_of( URI::Generic )
        expect( @body.path( full: false ).to_s ).to eq( 'cities' )
      end

    end

  end

  describe 'sample \'cities\' (pref_code: 1)' do

    before do
      @body = Resas::Api.client.get( 'cities', pref_code: 1 )
    end

    describe '#path' do

      it 'returns path for cities on the API' do
        expect( @body.path ).to be_present
        expect( @body.path ).to be_instance_of( URI::HTTPS )
        expect( @body.path.to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=1' )

        expect( @body.path( full: true ) ).to be_present
        expect( @body.path( full: true ) ).to be_instance_of( URI::HTTPS )
        expect( @body.path( full: true ).to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=1' )

        expect( @body.path( full: false ) ).to be_present
        expect( @body.path( full: false ) ).to be_instance_of( URI::Generic )
        expect( @body.path( full: false ).to_s ).to eq( 'cities?prefCode=1' )
      end

    end

  end

end
