class ReservationJob < ApplicationJob
  queue_as :default


  def perform(customer, listing_user, reservation)

    ReservationMailer.booking_email(customer, listing_user, reservation).deliver_later        

  end
end
