class Api::V1::MerchantSearchController < ApplicationController
  def search 
    merchant_list = Merchant.where("lower(name) like ?", "%#{params["name"].downcase}%").order(:name).limit(5)
    if merchant_list.empty?
      render(json: MerchantSerializer.new(merchant_list))
    else 
      render(json: MerchantSerializer.new(merchant_list))
    end 
  end
end