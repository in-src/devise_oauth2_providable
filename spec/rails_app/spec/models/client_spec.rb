require 'spec_helper'

describe Oauth2Client do
  describe 'basic client instance' do
    subject { Oauth2Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost' }
    it { should validate_presence_of :name }
    it { should validate_presence_of :website }
    it { should validate_presence_of :redirect_uri }
    it { should validate_uniqueness_of :identifier }
    it { should have_many :refresh_tokens }
    it { should have_db_index(:identifier).unique(true) }
  end
end
