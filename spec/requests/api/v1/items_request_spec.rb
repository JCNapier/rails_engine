require 'rails_helper'

RSpec.describe 'the items API' do
  it 'can get a list of items' do 
    id = create(:merchant).id 
    id_2 = create(:merchant).id 
    create_list(:item, 1, merchant_id: id)
    create_list(:item, 2, merchant_id: id_2)

    get api_v1_items_path

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

  it 'can get one item with its id' do 
    id = create(:merchant).id 
    item_id = create(:item, merchant_id: id).id

    get api_v1_item_path(item_id)
    
    item_json = JSON.parse(response.body, symbolize_names: true)
    item = item_json[:data]

    expect(response).to be_successful
    
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
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

    post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last
    
    expect(response).to be_successful

    expect(created_item.id).to be_a(Integer)
    expect(created_item.name).to be_a(String)
    expect(created_item.description).to be_a(String)
    expect(created_item.unit_price).to be_a(Float)
    expect(created_item.merchant_id).to be_a(Integer)
  end

  it 'can update an item' do 
    id = create(:item).id 
    previous_name = Item.last.name
    item_params = { name: "Alice In Chains Lego Set"}
    headers = {"CONTENT_TYPE" => "application/json"}
  # We include this header to make sure that these params 
  #are passed as JSON rather than as plain text
    
    patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params})
    
    item = Item.find_by(id: id)
    
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Alice In Chains Lego Set")
  end

  it 'can destroy an item' do 
    id = create(:merchant).id 
    item = create(:item, merchant_id: id)
   
    expect(Item.count).to eq(1)

    delete api_v1_item_path(item.id)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can find a merchant with an item id' do 
    id = create(:merchant).id 
    item_id = create(:item, merchant_id: id).id

    get "/api/v1/items/#{item_id}/merchant"
    
    merchant_json = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant_json[:data]
    
    expect(response).to be_successful
    
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end