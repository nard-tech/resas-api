require 'spec_helper'

describe Resas::Api::Client do

  describe 'default' do

    before do
      @client = Resas::Api::Client.new
    end

    describe 'attr_accessor' do

      it 'has method \'#access_key\'' do
        expect( @client ).to respond_to( :access_key )
      end

      it 'has method \'#access_key=\'' do
        expect( @client ).to respond_to( :access_key= )
      end

      it 'has method \'#base_url\'' do
        expect( @client ).to respond_to( :base_url )
      end

      it 'has method \'#base_url=\'' do
        expect( @client ).to respond_to( :base_url= )
      end

      it 'has method \'#format\'' do
        expect( @client ).to respond_to( :format )
      end

      it 'has method \'#format=\'' do
        expect( @client ).to respond_to( :format= )
      end

      it 'has method \'#api_version\'' do
        expect( @client ).to respond_to( :api_version )
      end

      it 'has method \'#api_version=\'' do
        expect( @client ).to respond_to( :api_version= )
      end

      it 'has method \'#adapter\'' do
        expect( @client ).to respond_to( :adapter )
      end

      it 'has method \'#adapter=\'' do
        expect( @client ).to respond_to( :adapter= )
      end

    end

    describe 'instance methods' do

      it 'has method \'#base_endpoint\'' do
        expect( @client ).to respond_to( :base_endpoint )
      end

      describe '#access_key' do

        it 'returns access key for the API' do
          expect( @client.access_key ).to be_present
          expect( @client.access_key ).to be_instance_of( String )
          expect( @client.access_key ).to eq( Resas::Api::DEFAULT_ACCESS_KEY )
          expect( @client.access_key ).to be_frozen
        end

      end

      describe '#base_url' do

        it 'returns base url for the API' do
          expect( @client.base_url ).to be_present
          expect( @client.base_url ).to be_instance_of( String )
          expect( @client.base_url ).to eq( Resas::Api::DEFAULT_BASE_URL )
          expect( @client.base_url ).to eq( 'https://opendata.resas-portal.go.jp' )
          expect( @client.base_url ).to be_frozen
        end

      end

      describe '#format' do

        it 'returns format of response from the API' do
          expect( @client.format ).to be_present
          expect( @client.format ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
          expect( @client.format ).to eq( Resas::Api::DEFAULT_FORMAT )
          expect( @client.format ).to eq( :json )
          expect( @client.format ).to be_frozen
        end

      end

      describe '#api_version' do

        it 'returns version of the API to access' do
          expect( @client.api_version ).to be_present
          expect( @client.api_version ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
          expect( @client.api_version ).to eq( Resas::Api::DEFAULT_API_VERSION )
          expect( @client.api_version ).to eq( 'v1' )
          expect( @client.api_version ).to be_frozen
        end

      end

      describe '#adapter' do

        it 'returns type of adapter for accessing to the API' do
          expect( @client.adapter ).to be_present
          expect( @client.adapter ).to be_instance_of( Symbol )
          expect( @client.adapter ).to eq( Resas::Api::DEFAULT_ADAPTER )
          expect( @client.adapter ).to eq( :net_http )
          expect( @client.adapter ).to be_frozen
        end

      end

      describe '#base_endpoint' do

        it 'returns the base endpoint of the API as an instance of URI::HTTPS' do
          expect( @client.base_endpoint ).to be_present
          expect( @client.base_endpoint ).to be_instance_of( URI::HTTPS )
          expect( @client.base_endpoint.to_s ).to eq( 'https://opendata.resas-portal.go.jp/api/v1' )
        end

      end

    end

  end

  describe 'after change' do

    before do
      @client = Resas::Api::Client.new

      @client.access_key = 'TestAccessKey'
      @client.base_url = 'https://api.resas-portal.go.jp'
      @client.format = 'xml'
      @client.api_version = 'v1-rc.2'
      @client.format = 'xml'
      @client.adapter = :test_adapter
    end

    describe 'instance methods' do

      describe '#access_key' do

        it 'returns access key for the API' do
          expect( @client.access_key ).to be_present
          expect( @client.access_key ).to be_instance_of( String )
          expect( @client.access_key ).to eq( 'TestAccessKey' )
        end

      end

      describe '#base_url' do

        it 'returns base url for the API' do
          expect( @client.base_url ).to be_present
          expect( @client.base_url ).to be_instance_of( String )
          expect( @client.base_url ).to eq( 'https://api.resas-portal.go.jp' )
        end

      end

      describe '#format' do

        it 'returns format of response from the API' do
          expect( @client.format ).to be_present
          expect( @client.format ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
          expect( @client.format ).to eq( 'xml' )
        end

      end

      describe '#api_version' do

        it 'returns version of the API to access' do
          expect( @client.api_version ).to be_present
          expect( @client.api_version ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
          expect( @client.api_version ).to eq( 'v1-rc.2' )
        end

      end

      describe '#adapter' do

        it 'returns type of adapter for accessing to the API' do
          expect( @client.adapter ).to be_present
          expect( @client.adapter ).to be_instance_of( Symbol )
          expect( @client.adapter ).to eq( :test_adapter )
          expect( @client.adapter ).to be_frozen
        end

      end

      describe '#base_endpoint' do

        it 'returns the base_endpoint of the API as an instance of URI::HTTPS' do
          expect( @client.base_endpoint ).to be_present
          expect( @client.base_endpoint ).to be_instance_of( URI::HTTPS )
          expect( @client.base_endpoint.to_s ).to eq( 'https://api.resas-portal.go.jp/api/v1-rc.2' )
        end

      end

    end

  end

end
