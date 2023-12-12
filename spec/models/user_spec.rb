require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    load_test_data
  end

  describe '#validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password)}
  end

  describe '#relations' do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
  end
end