require 'rails_helper'

RSpec.describe 'the merchants API' do
  it 'sends a list of merchants' do 
    create_list(:merchant, 3)

    # get api_v1_merchants_path
    get "/api/v1/merchants"

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    
    merchants = merchant_json[:data]

    expect(response).to be_successful
    
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can get one merchant by its id' do 
    id = create(:merchant).id 

    get api_v1_merchant_path(id)

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant_json[:data]
    
    expect(response).to be_successful

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'can get all of the items associated with a merchant' do 
    id = create(:merchant).id 
    create_list(:item, 3, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    item_json = JSON.parse(response.body, symbolize_names: true)
    
    items = item_json[:data]
    
    expect(response).to be_successful

    items.each do |item| 
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end