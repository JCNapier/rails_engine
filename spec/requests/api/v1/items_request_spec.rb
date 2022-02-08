require 'rails_helper'

RSpec.describe 'the items API' do
  it 'can get a list of items' do 
    id = create(:merchant).id 
    id_2 = create(:merchant).id 
    create_list(:item, 1, merchant_id: id)
    create_list(:item, 2, merchant_id: id_2)

    get '/api/v1/items'

    items = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful 

    items.each do |item| 
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_a(Integer)
    end
  end

  it 'can get one item with its id' do 
    id = create(:merchant).id 
    item_id = create(:item, merchant_id: id).id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(Integer)
    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)
    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to be_a(Integer)
  end

  it 'can create an item' do 
    id = create(:merchant).id
    item_params = ({
      name: "Harry Potter Lego",
      description: "Hagrid's Hut",
      unit_price: 50.0,
      merchant_id: id
      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.id).to be_a(Integer)
    expect(created_item.name).to be_a(String)
    expect(created_item.description).to be_a(String)
    expect(created_item.unit_price).to be_a(Float)
    expect(created_item.merchant_id).to be_a(Integer)
  end

  it 'can edit an item' do 
    id = create(:merchant).id 
    item_id = create(:item, merchant_id: id).id

    get "/api/v1/items/#{item_id}/edit"

    item = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(Integer)
    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)
    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to be_a(Integer)
  end

  it 'can destroy an item' do 
    id = create(:merchant).id 
    item = create(:item, merchant_id: id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can find a merchant with an item id' do 
    id = create(:merchant).id 
    item = create(:item, merchant_id: id)

    get "/api/v1/items/#{item.id}/merchants/#{item.merchant_id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
end