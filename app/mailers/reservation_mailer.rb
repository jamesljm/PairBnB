class ReservationMailer < ApplicationMailer
    def booking_email(customer, host, reservation)


        @customer = customer
        @host = host
        @reservation = reservation 

        @url = listing_reservation_url(@reservation.listing_id, @reservation.id)

        mail(to: @customer.email, subject: 'Your booking')
    end
end