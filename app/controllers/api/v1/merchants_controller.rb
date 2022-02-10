class Api::V1::MerchantsController < ApplicationController 
  def index 
    render(json: MerchantSerializer.new(Merchant.all))
  end

  def show 
    render(json: MerchantSerializer.new(Merchant.find(params[:id])))
  end

  def search 
    merchant_list = Merchant.where("lower(name) like ?", "%#{params["name"].downcase}%").order(:name).limit(5)
    if merchant_list.empty?
      render(json: MerchantSerializer.new(merchant_list))
    else 
      render(json: MerchantSerializer.new(merchant_list))
    end 
  end
end