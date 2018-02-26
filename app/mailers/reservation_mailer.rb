class ReservationMailer < ApplicationMailer
    def booking_email(customer, host, reservation)
        @customer = customer
        @host = host
        @reservation = reservation 
    


        @url = listing_reservation_path(@reservation.id)
    end
end