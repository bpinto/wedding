class GuestsController < ApplicationController
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

  protected

  def guest_params
    params.require(:guest).permit(:name, :companies, :confirmed?, :email, :email_message, :product_id, :total_guests)
  end
end
