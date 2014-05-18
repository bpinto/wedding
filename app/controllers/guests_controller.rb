class GuestsController < ApplicationController
  def new
    @guest = Guest.new
  end

  def create
    binding.pry
    @guest = Guest.new guest_params
    if @guest.save
      redirect_to root_path
    else
      render :new
    end
  end

  protected

  def guest_params
    params.require(:guest).permit(:name, :email, :total_guests, :confirmed, companions: [])
  end
end
