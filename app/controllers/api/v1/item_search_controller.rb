class Api::V1::ItemSearchController < ApplicationController
  def search   
    if (params[:name].present? && !params[:min_price].present?) && (params[:name].present? && !params[:max_price].present?)
      item_name = Item.where("lower(name) LIKE ?", "%#{params[:name].downcase}%")
                      .order(:name)
                      .first
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
      item = Item.where("unit_price >= ?", (params[:min_price].to_f))
                 .order(:name)
                 .first
      if (params[:min_price].to_f) < 0
        render(json: {error: "min_price can't be less than 0"}, status: 400)
      elsif item == nil
        render(json: {data: {message: "No Items Found"}})
      else 
        render(json: ItemSerializer.new(item))
      end
    elsif params[:max_price].present?
      item = Item.where("unit_price <= ?", (params[:max_price].to_f))
                 .first
      if (params[:max_price].to_f) < 0
        render(json: {error: "max_price can't be less than 0"}, status: 400)
      else 
        render(json: ItemSerializer.new(item))
      end
    else 
      render(json: {data: {message: "Insufficient Params"}})
    end 
  end

  private 
  def item_params 
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end