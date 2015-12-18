class Admin::PriceRequestsController < Admin::BaseController

  def index
    @price_requests = PriceRequest.order('id DESC').all
  end

  def close
    @price_request = PriceRequest.find(params[:id])
    @price_request.update_attributes(closed: true)
    redirect_to admin_price_requests_path
  end
end
