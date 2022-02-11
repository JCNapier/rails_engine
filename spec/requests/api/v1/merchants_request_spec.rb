require 'rails_helper'

RSpec.describe 'the merchants API' do
  it 'sends a list of merchants' do 
    create_list(:merchant, 3)

    get api_v1_merchants_path

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

  # it 'gets empty array for merchants case insensitive name search' do 
  #   get "/api/v1/merchants/find_all?name=#{"name"}"

  #   merchant_json = JSON.parse(response.body, symbolize_names: true)

  #   expect(response).to be_successful 
  #   expect(merchant_json[:data]).to be_a(Array)
  #   expect(merchant_json[:data].empty?).to be(true)
  # end

  # it 'can get merchants for case insensitive name search' do
  #   create(:merchant, name: 'Largemouth Bass')
  #   create(:merchant, name: 'Smallmouth Bass')
  #   create(:merchant, name: 'White Bass')
  #   create(:merchant, name: 'Striped Bass')
  #   create(:merchant, name: 'Spotted Bass')
  #   create(:merchant, name: 'Sea Bass')
  #   create(:merchant, name: 'Channel Catfish')

  #   get "/api/v1/merchants/find_all?name=#{"bAsS"}"
    
  #   merchant_json = JSON.parse(response.body, symbolize_names: true)
  
  #   merchant = merchant_json[:data]

  #   expect(response).to be_successful 
    
  #   expect(merchant).to be_a(Array)
  #   expect(merchant.first[:attributes]).to be_a(Hash)
  #   expect(merchant.first[:attributes]).to have_key(:name)
  #   expect(merchant.first[:attributes][:name]).to eq("Largemouth Bass")
  # end
end