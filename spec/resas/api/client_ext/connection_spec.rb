require 'spec_helper'

describe Resas::Api::Client do

  describe 'defined in Resas::Api::ClientExt::Connection' do

    before do
      @client = Resas::Api.client
    end

    it 'has private instance method \'#connection\'' do
      expect( :connection ).to be_in( @client.private_methods )
    end

    describe '#connection (private)' do

      it 'returns an instance of Faraday::Connection' do
        expect( @client.send( :connection, parse_json: true, generate_instance: false ) ).to be_instance_of( Faraday::Connection )
      end

    end

    it 'has private instance method \'#options_for_connection\'' do
      expect( :options_for_connection ).to be_in( @client.private_methods )
    end

    describe '#options_for_connection (private)' do

      it 'returns options for connection to the API as an instance of Hash' do
        expect( @client.send( :options_for_connection ) ).to be_present
        expect( @client.send( :options_for_connection ) ).to be_instance_of( Hash )
        expect( @client.send( :options_for_connection ).keys.sort ).to eq( [ :headers, :url ] )
      end

      it 'has key :headers' do
        expect( @client.send( :options_for_connection ) ).to have_key( :headers )
      end

      describe 'key :headers' do

        it 'returns options of header on request to the API as an instance of Hash' do
          expect( @client.send( :options_for_connection )[ :headers ] ).to be_present
          expect( @client.send( :options_for_connection )[ :headers ] ).to be_instance_of( Hash )
          expect( @client.send( :options_for_connection )[ :headers ].keys.sort ).to eq( [ 'Content-Type', 'X-API-KEY'] )
        end

        it 'has key \'X-API-KEY\'' do
          expect( @client.send( :options_for_connection )[ :headers ] ).to have_key( 'X-API-KEY' )
        end

        describe 'key \'X-API-KEY\'' do

          it 'returns the access key for the API' do
            expect( @client.send( :options_for_connection )[ :headers ][ 'X-API-KEY' ] ).to be_present
            expect( @client.send( :options_for_connection )[ :headers ][ 'X-API-KEY' ] ).to be_instance_of( String )
            expect( @client.send( :options_for_connection )[ :headers ][ 'X-API-KEY' ] ).to eq( @client.access_key )
          end

        end

        it 'has key \'Content-Type\'' do
          expect( @client.send( :options_for_connection )[ :headers ] ).to have_key( 'Content-Type' )
        end

        describe 'key \'Content-Type\'' do

          it 'returns content type of data fetching from the API' do
            expect( @client.send( :options_for_connection )[ :headers ][ 'Content-Type' ] ).to be_present
            expect( @client.send( :options_for_connection )[ :headers ][ 'Content-Type' ] ).to be_instance_of( String )
            expect( @client.send( :options_for_connection )[ :headers ][ 'Content-Type' ] ).to eq( 'application/json;charset=UTF-8' )
          end

        end

      end

      it 'has key :url' do
        expect( @client.send( :options_for_connection ) ).to have_key( :url )
      end

      describe 'key :url' do

        it 'returns the base endpoint of the API as an instance of URI::HTTPS' do
          expect( @client.send( :options_for_connection )[ :url ] ).to be_present
          expect( @client.send( :options_for_connection )[ :url ] ).to be_instance_of( URI::HTTPS )
          expect( @client.send( :options_for_connection )[ :url ].to_s ).to eq( @client.base_endpoint.to_s )
        end

      end

    end

  end

end
