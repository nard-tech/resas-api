require "spec_helper"

describe Resas::Api do

  it 'has a version number of this Gem' do
    expect(Resas::Api::VERSION).not_to be nil
  end

  describe '.#api_version' do
    it "has a class instance variable '@api_version'." do
      expect( Resas::Api.api_version ).to eq( 'v1-rc.1' )
    end
  end

  describe '.#client' do
    it 'returns and instance of Resas::Api::Client (singleton).' do
      expect( Resas::Api.client ).to eq( Resas::Api::Client.instance )
      expect( Resas::Api.client ).to be_instance_of( Resas::Api::Client )
    end
  end

end
