require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let!(:merchant_1) {FactoryBot.create(:merchant, name: 'Largemouth Bass')}
  let!(:merchant_2) {FactoryBot.create(:merchant, name: 'White Bass')}
  let!(:merchant_3) {FactoryBot.create(:merchant, name: 'Smallmouth Bass')}
  let!(:merchant_4) {FactoryBot.create(:merchant, name: 'Striped Bass')}
  let!(:merchant_5) {FactoryBot.create(:merchant, name: 'Spotted Bass')}
  let!(:merchant_6) {FactoryBot.create(:merchant, name: 'Sea Bass')}
  let!(:merchant_7) {FactoryBot.create(:merchant, name: 'Channel Catfish')}
  
  describe 'relationships' do
    it { should have_many(:items)}
  end

  describe 'validations' do 
    it { should validate_presence_of(:name)}
  end

  it '.find by name' do     
    result = Merchant.find_by_name('bass')

    expect(result.count).to eq(5)
    expect(result).to eq([merchant_1, merchant_6, merchant_3, merchant_5, merchant_4])
  end
end