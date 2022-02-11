class Api::V1::MerchantSearchController < ApplicationController
  def search 
    merchant_list = Merchant.find_by_name(params[:name])
    if merchant_list.empty?
      render(json: MerchantSerializer.new(merchant_list))
    else 
      render(json: MerchantSerializer.new(merchant_list))
    end 
  end
end