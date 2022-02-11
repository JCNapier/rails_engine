require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:item_1) {FactoryBot.create(:item, name: 'JuneBug', unit_price: 50)}
  let!(:item_2) {FactoryBot.create(:item, name: 'Power Nymph Bug', unit_price: 100)}
  let!(:item_3) {FactoryBot.create(:item, name: 'Crawfish CrankBait', unit_price: 150)}
 
  describe 'relationships' do 
    it { should belong_to(:merchant)}
  end

  describe 'validations' do 
    it {should validate_presence_of(:name) }
    it {should validate_presence_of(:description) }
    it {should validate_presence_of(:unit_price) }
    it {should validate_presence_of(:merchant_id) }
  end

  it '.find by name' do 
    expect(Item.find_by_name('bug')).to eq(item_1)
  end

  it '.find by min price' do 
    expect(Item.find_by_min_price(100)).to eq(item_3)
  end

  it '.find by max price' do 
    expect(Item.find_by_max_price(100)).to eq(item_1)
  end
end