require 'spec_helper'

describe Resas::Api::ClientExt::Endpoints do

  describe 'cities' do

    describe 'bug of RESAS API' do

      describe 'Tokyo (pref code: 13)' do

        before do
          @pref_code_of_tokyo = 13
          @cities_in_tokyo = Resas::Api.cities( pref_code: @pref_code_of_tokyo ).result
          @undecided_area = @cities_in_tokyo.find { | city | city[ 'cityName' ] == '境界未定地域' }
        end

        it 'has undecided area' do
          expect( @undecided_area ).to be_present
          expect( @undecided_area[ 'prefCode' ] ).to eq( @pref_code_of_tokyo )
          expect( @undecided_area[ 'prefCode' ] ).to eq( '境界未定地域' )
          expect( @undecided_area[ 'cityCode' ] ).to eq( '13199' )
        end

      end

    end

  end

end
