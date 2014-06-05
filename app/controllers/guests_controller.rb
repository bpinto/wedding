class GuestsController < ApplicationController
  before_filter :authenticate, only: :index

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new guest_params
    if @guest.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @guests = Guest.all
    @total_confirmed = Guest.total_confirmed
    @total_unconfirmed = Guest.total_unconfirmed
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "casamento" && password == "2014-08-09"
    end
  end

  def guest_params
    params.require(:guest).permit(:name, :email, :total_guests, :confirmed, companions: [])
  end
end
