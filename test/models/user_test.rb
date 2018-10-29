require 'test_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    user = described_class.new(
        first_name:'foo',
        last_name: 'bar',
        location:'argentina',
        email: 'rspec@rspec.com',
        password: 'Ab123!'
      )

    it { should have_secure_password }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is valid without a name" do
      user.name = nil
      expect(user).to be_valid
    end

    it "is valid without a location" do
      user.location = nil
      expect(user).to be_valid
    end

  # EMAIL
    it "is not valid with invalid email format" do
      user.email = 'abc.example.com.'
      expect(user).to_not be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

  # PASSWORD
    it "is not valid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end
  end

# ASSOCIATION
  describe "association" do
    it { should have_one(:portfolio) }
    it { should have_many(:crypto) }
    it { should have_many(:authentications) }
  end
end