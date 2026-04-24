class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Current.user.requests.new(request_params)
    if @request.save
      redirect_to requests_path, notice: "Request created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if Current.user.vendor?
      @requests = Current.user.requests
    else
      @requests = Request.where(state: "open")
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  private
  def request_params
    params.expect(request: [:make, :model, :year, :mileage ])
  end
end
