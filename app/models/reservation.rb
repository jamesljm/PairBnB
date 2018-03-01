class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :listing
    validates :listing_price, presence: true, allow_nil: false
    # validates :start_date, presence: true, date: { after_or_equal_to: Proc.new { Date.today }, message: "must be at least #{(Date.today + 1).to_s}" }, on: :create

    # validates :end_date, presence: true, date: { after_or_equal_to: :start_date}, on: [:create, :edit]

    validates_presence_of :start_date, :end_date

    validate :end_date_is_after_start_date

    validate :overlap_dates

    validate :start_date_after_today

    def overlap_dates 
        if self.listing.reservations.where("(? >= start_date AND ? < end_date) OR (? > start_date AND ? <= end_date)", self.start_date, self.start_date, self.end_date, self.end_date).count != 0
        errors.add(:start_date, " overlaps")
        end
    end

    def start_date_after_today
        errors.add(:start_date, "before today") if self.start_date < Date.today
    end

    def calc_date_diff
        (self.end_date-self.start_date).to_i
    end

    def calc_total_price 
        total_price = calc_date_diff * self.listing.price
    end
    

    #######
    private
    #######

    def end_date_is_after_start_date
        return if end_date.blank? || start_date.blank?
        if end_date <= start_date
            errors.add(:end_date, "cannot be before the start date") 
        end 
    end
end