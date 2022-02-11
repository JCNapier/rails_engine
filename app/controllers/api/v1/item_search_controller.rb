class Api::V1::ItemSearchController < ApplicationController
  def search   
    if (params[:name].present? && !params[:min_price].present?) && (params[:name].present? && !params[:max_price].present?)
      item_name = Item.find_by_name(params[:name])
      if item_name == nil 
        render(json: {data: {message: "No Items Found"}})
      elsif item_name != nil 
        render(json: ItemSerializer.new(item_name))
      end
    elsif params[:min_price].present? && params[:name].present?
      render(json: {error: "cannot pass min price and name params"}, status: 400)
    elsif params[:max_price].present? && params[:name].present?
      render(json: {error: "cannot pass max price and name params"}, status: 400)
    elsif params[:min_price].present?
      item = Item.find_by_min_price(params[:min_price])
      if (params[:min_price].to_f) < 0
        render(json: {error: "min_price can't be less than 0"}, status: 400)
      elsif item == nil
        render(json: {data: {message: "No Items Found"}})
      else 
        render(json: ItemSerializer.new(item))
      end
    elsif params[:max_price].present?
      item = Item.find_by_max_price(params[:max_price])
      if (params[:max_price].to_f) < 0
        render(json: {error: "max_price can't be less than 0"}, status: 400)
      else 
        render(json: ItemSerializer.new(item))
      end
    end 
  end
end