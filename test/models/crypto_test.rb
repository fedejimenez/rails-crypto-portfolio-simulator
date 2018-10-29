require 'spec_helper'
require 'rails_helper'
require_relative "../../app/models/crypto"
require_relative "../../app/models/movements"


RSpec.describe Crypto, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:portfolio) }
  end
end