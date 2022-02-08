class Api::V1::ItemMerchantsController < ApplicationController 
  def show 
    render(json: MerchantSerializer.new(Item.find(params[:id]).merchant))
  end
end