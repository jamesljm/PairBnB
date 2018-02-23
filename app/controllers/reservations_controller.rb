class ReservationsController < ApplicationController

    before_action :require_login
    before_action :set_listing, only: [:new, :create]
    # before_action :set_reservation, only: [:edit]

    def new
        @reservation = Reservation.new
    end

    def create 
        @reservation = current_user.reservations.new(reservation_params)
        @reservation.listing_id = params[:listing_id]
        if @reservation.save            
            render template: "reservations/confirmation"
        else
            redirect_back(fallback_location: new_listing_reservation_path)
            flash[:notice] = (@reservation.errors.full_messages)
        end
    end

    private

    # def set_listing
    #     @listing = Lisiting.find(params[:id])
    # end

    def reservation_params
        params.require(:reservation).permit(:start_date, :end_date, :user_id, :listing_id, :listing_price)

    end

    def set_reservation
        @reservation = Reservation.find(params[:id])
    end

    def set_listing
        @listing = Listing.find(params[:listing_id])
    end
end