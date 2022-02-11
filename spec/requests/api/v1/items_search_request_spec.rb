require 'rails_helper'

RSpec.describe 'item search requests' do
  context 'happy path endpoints' do 
    it 'gets an item from case insensitive name search' do
      create(:item, name: "ampeg classic")
      create(:item, name: "JaMpeg classic")
      create(:item, name: "Aguilar", description: "Similar to Ampeg")

      get "/api/v1/items/find?name=Ampeg"

      item_json = JSON.parse(response.body, symbolize_names: true)
      item = item_json[:data]

      expect(response).to be_successful
      expect(item).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it 'gets an item from min price search' do
      create_list(:item, 5)
      create(:item, name: "Aguilar", unit_price: 10000.0)

      get "/api/v1/items/find?min_price=9999"

      item_json = JSON.parse(response.body, symbolize_names: true)
      expect(item_json.count).to eq(1)
      
      item = item_json[:data]
      
      expect(response).to be_successful
      expect(item).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it 'min price is so big nothing matches' do
      create(:item, name: "Ampeg", unit_price: 50.0)
      create(:item, name: "Fodera", unit_price: 100.0)
      create(:item, name: "Aguilar", unit_price: 150.0)

      get "/api/v1/items/find?min_price=100_000"

      item_json = JSON.parse(response.body, symbolize_names: true)
      
      expect(item_json.count).to eq(1)

      item = item_json[:data]
      
      expect(response).to be_successful
      
      expect(item).to be_a(Hash)
      expect(item).to have_key(:message)
      expect(item[:message]).to be_a(String)
    end

    it 'gets an item from max price search' do
      create(:item, name: "Ampeg", unit_price: 50.0)
      create(:item, name: "Fodera", unit_price: 100.0)
      create(:item, name: "Aguilar", unit_price: 150.0)

      get "/api/v1/items/find?max_price=150"

      item_json = JSON.parse(response.body, symbolize_names: true)
      item = item_json[:data]
      
      expect(response).to be_successful
      expect(item).to be_a(Hash)
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

  context 'sad path endpoints' do 
    it 'gets an empty array from single item case insensitive search' do
      get "/api/v1/items/find?name=#{"Ampeg"}"

      item_json = JSON.parse(response.body, symbolize_names: true)
      item = item_json[:data]

      expect(response).to be_successful
      expect(item).to be_a(Hash)
      expect(item[:message]).to be_a(String)
      expect(item[:message]).to eq("No Items Found")
    end

    it 'min price is less than 0' do 
      create_list(:item, 5)

      get "/api/v1/items/find?min_price=-1"

      item_json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(item_json).to have_key(:error)
      expect(item_json[:error]).to be_a(String)
    end

    it 'max price less than 0' do 
      create_list(:item, 5)

      get "/api/v1/items/find?max_price=-1"

      item_json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(item_json).to have_key(:error)
      expect(item_json[:error]).to be_a(String)
    end

    it 'cant send name and min price params' do 
      create_list(:item, 5)

      get "/api/v1/items/find?name=ring&min_price=50"

      item_json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(item_json).to have_key(:error)
      expect(item_json[:error]).to be_a(String)
    end

    it 'cant send name and max price params' do 
      create_list(:item, 5)

      get "/api/v1/items/find?name=ring&max_price=50"

      item_json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(item_json).to have_key(:error)
      expect(item_json[:error]).to be_a(String)
    end
  end
end