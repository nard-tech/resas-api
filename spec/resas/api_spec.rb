require 'spec_helper'

describe Resas::Api do

  describe '[Version]' do

    it 'has constant \'VERSION\'.' do
      expect( Resas::Api::VERSION ).to be_present
      expect( Resas::Api::VERSION ).to be_instance_of( String )
      expect( Resas::Api::VERSION ).to eq( '0.3.0' )
      expect( Resas::Api::VERSION ).to be_frozen
    end

    it 'has class method \'.#gem_version\'' do
      expect( Resas::Api ).to respond_to( :gem_version )
    end

    describe '.#gem_version (see also: Nard::Appi::ApiExt::Version)' do

      it 'returns version of this gem' do
        expect( Resas::Api.gem_version ).to be_present
        expect( Resas::Api.gem_version ).to be_instance_of( String )
        expect( Resas::Api.gem_version ).to eq( Resas::Api::VERSION )
        expect( Resas::Api.gem_version ).to be_frozen
      end

    end

  end

  describe '[Client]' do

    it 'has class method \'.#client\'' do
      expect( Resas::Api ).to respond_to( :client )
    end

    describe '.#client (see also: Nard::Appi::ApiExt::Client)' do

      it 'returns an instance of Resas::Api::Client' do
        expect( Resas::Api.client ).to be_instance_of( Resas::Api::Client )
      end

    end

  end

  describe '[Constants] (see also: Resas::Api::ApiExt::DefaultConfiguration, Nard::Appi::ApiExt::DefaultConfiguration)' do

    it 'has constant \'OPTIONS_KEYS\'' do
      expect( :OPTIONS_KEYS ).to be_in( Resas::Api.constants )
    end

    it 'has constant \'DEFAULT_ACCESS_KEY\'' do
      expect( :DEFAULT_ACCESS_KEY ).to be_in( Resas::Api.constants )
    end

    it 'has constant \'DEFAULT_BASE_URL\'' do
      expect( :DEFAULT_BASE_URL ).to be_in( Resas::Api.constants )
    end

    it 'has constant \'DEFAULT_FORMAT\'' do
      expect( :DEFAULT_FORMAT ).to be_in( Resas::Api.constants )
    end

    it 'has constant \'DEFAULT_API_VERSION\'' do
      expect( :DEFAULT_API_VERSION ).to be_in( Resas::Api.constants )
    end

    it 'has constant \'DEFAULT_ADAPTER\'' do
      expect( :DEFAULT_ADAPTER ).to be_in( Resas::Api.constants )
    end

    describe 'constant \'OPTIONS_KEYS\'' do

      it 'returns keys for configuration of Resas::Api' do
        expect( Resas::Api::OPTIONS_KEYS ).to be_present
        expect( Resas::Api::OPTIONS_KEYS ).to be_instance_of( Array )
        expect( Resas::Api::OPTIONS_KEYS ).to all( be_instance_of( Symbol ) )
        expect( Resas::Api::OPTIONS_KEYS ).to eq( [ :access_key, :base_url, :format, :api_version, :adapter ] )
        expect( Resas::Api::OPTIONS_KEYS ).to be_frozen
      end

    end

    describe 'constant \'DEFAULT_ACCESS_KEY\'' do

      it 'returns default access key for accessing to the API' do
        expect( Resas::Api::DEFAULT_ACCESS_KEY ).to be_present
        expect( Resas::Api::DEFAULT_ACCESS_KEY ).to be_instance_of( String )
        expect( Resas::Api::DEFAULT_ACCESS_KEY ).to be_frozen
      end

    end

    describe 'constant \'DEFAULT_BASE_URL\'' do

      it 'returns default base url for the API' do
        expect( Resas::Api::DEFAULT_BASE_URL ).to be_present
        expect( Resas::Api::DEFAULT_BASE_URL ).to be_instance_of( String )
        expect( Resas::Api::DEFAULT_BASE_URL ).to eq( 'https://opendata.resas-portal.go.jp' )
        expect( Resas::Api::DEFAULT_BASE_URL ).to be_frozen
      end

    end

    describe 'constant \'DEFAULT_FORMAT\'' do

      it 'returns default format of response from the API' do
        expect( Resas::Api::DEFAULT_FORMAT ).to be_present
        expect( Resas::Api::DEFAULT_FORMAT ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
        expect( Resas::Api::DEFAULT_FORMAT ).to eq( :json )
        expect( Resas::Api::DEFAULT_FORMAT ).to be_frozen
      end

    end

    describe 'constant \'DEFAULT_API_VERSION\'' do

      it 'returns default version of the API to access' do
        expect( Resas::Api::DEFAULT_API_VERSION ).to be_present
        expect( Resas::Api::DEFAULT_API_VERSION ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
        expect( Resas::Api::DEFAULT_API_VERSION ).to eq( 'v1-rc.1' )
        expect( Resas::Api::DEFAULT_API_VERSION ).to be_frozen
      end

    end

    describe 'constant \'DEFAULT_ADAPTER\'' do

      it 'returns default type of adapter for accessing to the API' do
        expect( Resas::Api::DEFAULT_ADAPTER ).to be_present
        expect( Resas::Api::DEFAULT_ADAPTER ).to be_instance_of( Symbol )
        expect( Resas::Api::DEFAULT_ADAPTER ).to eq( :net_http )
        expect( Resas::Api::DEFAULT_ADAPTER ).to be_frozen
      end

    end

  end

  describe '[Module methods]' do

    describe 'attr_accessor (see also: Resas::Api::ApiExt::DefaultConfiguration, Nard::Appi::ApiExt::Initializer)' do

      it 'has module method \'#access_key\'' do
        expect( Resas::Api ).to respond_to( :access_key )
      end

      it 'has module method \'#access_key=\'' do
        expect( Resas::Api ).to respond_to( :access_key= )
      end

      it 'has module method \'#base_url\'' do
        expect( Resas::Api ).to respond_to( :base_url )
      end

      it 'has module method \'#base_url=\'' do
        expect( Resas::Api ).to respond_to( :base_url= )
      end

      it 'has module method \'#format\'' do
        expect( Resas::Api ).to respond_to( :format )
      end

      it 'has module method \'#format=\'' do
        expect( Resas::Api ).to respond_to( :format= )
      end

      it 'has module method \'#api_version\'' do
        expect( Resas::Api ).to respond_to( :api_version )
      end

      it 'has module method \'#api_version=\'' do
        expect( Resas::Api ).to respond_to( :api_version= )
      end

      it 'has module method \'#adapter\'' do
        expect( Resas::Api ).to respond_to( :adapter )
      end

      it 'has module method \'#adapter=\'' do
        expect( Resas::Api ).to respond_to( :adapter= )
      end

      describe '.#access_key' do

        it 'returns access key for accessing to the API' do
          expect( Resas::Api.access_key ).to be_present
          expect( Resas::Api.access_key ).to be_instance_of( String )
          expect( Resas::Api.access_key ).to eq( Resas::Api::DEFAULT_ACCESS_KEY )
          expect( Resas::Api.access_key ).to be_frozen
        end

      end

      describe '.#base_url' do

        it 'returns base url for the API' do
          expect( Resas::Api.base_url ).to be_present
          expect( Resas::Api.base_url ).to be_instance_of( String )
          expect( Resas::Api.base_url ).to eq( Resas::Api::DEFAULT_BASE_URL )
          expect( Resas::Api.base_url ).to be_frozen
        end

      end

      describe '.#format' do

        it 'returns format of response from the API' do
          expect( Resas::Api.format ).to be_present
          expect( Resas::Api.format ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
          expect( Resas::Api.format ).to eq( Resas::Api::DEFAULT_FORMAT )
          expect( Resas::Api.format ).to eq( :json )
          expect( Resas::Api.format ).to be_frozen
        end

      end

      describe '.#api_version' do

        it 'returns version of the API to access' do
          expect( Resas::Api.api_version ).to be_present
          expect( Resas::Api.api_version ).to be_instance_of( Symbol ).or( be_instance_of( String ) )
          expect( Resas::Api.api_version ).to eq( Resas::Api::DEFAULT_API_VERSION )
          expect( Resas::Api.api_version ).to eq( 'v1-rc.1' )
          expect( Resas::Api.api_version ).to be_frozen
        end

      end

      describe '.#adapter' do

        it 'returns type of adapter for accessing to the API' do
          expect( Resas::Api.adapter ).to be_present
          expect( Resas::Api.adapter ).to be_instance_of( Symbol )
          expect( Resas::Api.adapter ).to eq( Resas::Api::DEFAULT_ADAPTER )
          expect( Resas::Api.adapter ).to eq( :net_http )
          expect( Resas::Api.adapter ).to be_frozen
        end

      end

    end

    describe 'defined in Resas::Api::ApiExt::Configuration' do

      it 'has module method \'.#options\'' do
        expect( Resas::Api ).to respond_to( :options )
      end

      it 'has module method \'.#reset!\'' do
        expect( Resas::Api ).to respond_to( :reset! )
      end

      describe '.#options' do

        it 'returns options of Resas::Api as an instance of Hash' do
          expect( Resas::Api.options ).to be_present
          expect( Resas::Api.options ).to be_instance_of( Hash )
          expect( Resas::Api.options.keys ).to eq( Resas::Api::OPTIONS_KEYS )
          expect( Resas::Api.options ).to eq(
            access_key: Resas::Api.access_key,
            base_url: Resas::Api.base_url,
            format: Resas::Api.format,
            api_version: Resas::Api.api_version,
            adapter: Resas::Api.adapter,
          )
        end

      end

      describe '.#default_options' do

        it 'returns default options of Resas::Api as an instance of Hash' do
          expect( Resas::Api.default_options ).to be_present
          expect( Resas::Api.default_options ).to be_instance_of( Hash )
          expect( Resas::Api.default_options.keys ).to eq( Resas::Api::OPTIONS_KEYS )
          expect( Resas::Api.default_options ).to eq(
            access_key: Resas::Api::DEFAULT_ACCESS_KEY,
            base_url: Resas::Api::DEFAULT_BASE_URL,
            format: Resas::Api::DEFAULT_FORMAT,
            api_version: Resas::Api::DEFAULT_API_VERSION,
            adapter: Resas::Api::DEFAULT_ADAPTER,
          )
        end

      end

      describe '.#reset!' do

        it 'resets settings of Resas::Api and returns options of Resas::Api as an instance of Hash' do
          expect( Resas::Api.reset! ).to be_present
          expect( Resas::Api.reset! ).to be_instance_of( Hash )
          expect( Resas::Api.reset!.keys ).to eq( Resas::Api::OPTIONS_KEYS )
        end

      end

      describe '.#configure' do

        before do
          Resas::Api.configure do | config |
            config.access_key = 'TestAccessKey'
            config.base_url = 'https://api.resas-portal.go.jp'
            config.format = 'xml'
            config.api_version = 'v1-rc.2'
            config.adapter = :test_adapter
          end
        end

        describe 'After change by .#configure' do

          describe '.#options' do

            it 'returns options of Resas::Api after changing configurations as an instance of Hash' do
              expect( Resas::Api.options ).to be_present
              expect( Resas::Api.options ).to be_instance_of( Hash )
              expect( Resas::Api.options.keys ).to eq( Resas::Api::OPTIONS_KEYS )
              expect( Resas::Api.options ).to eq({
                access_key: 'TestAccessKey',
                base_url: 'https://api.resas-portal.go.jp',
                format: 'xml',
                api_version: 'v1-rc.2',
                adapter: :test_adapter,
              })
            end

          end

          describe 'attr_accessor' do

            describe '.#access_key' do

              it 'returns access key for accessing to the API after changing configurations' do
                expect( Resas::Api.access_key ).to eq( 'TestAccessKey' )
                expect( Resas::Api.access_key ).not_to be_frozen
              end

            end

            describe '.#base_url' do

              it 'returns the base url for the API after changing configurations' do
                expect( Resas::Api.base_url ).to eq( 'https://api.resas-portal.go.jp' )
                expect( Resas::Api.base_url ).not_to be_frozen
              end

            end

            describe '.#format' do

              it 'returns format of response from the API after changing configurations' do
                expect( Resas::Api.format ).to eq( 'xml' )
                expect( Resas::Api.format ).not_to be_frozen
              end

            end

            describe '.#api_version' do

              it 'returns version of the API to access after changing configurations' do
                expect( Resas::Api.api_version ).to eq( 'v1-rc.2' )
                expect( Resas::Api.api_version ).not_to be_frozen
              end

            end

            describe '.#adapter' do

              it 'returns type of adapter for accessing to the API after changing configurations' do
                expect( Resas::Api.adapter ).to eq( :test_adapter )
                expect( Resas::Api.adapter ).to be_frozen
              end

            end

          end

        end

        after do
          Resas::Api.reset!
        end

      end

    end

  end

end
