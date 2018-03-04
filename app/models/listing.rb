class Listing < ApplicationRecord

    belongs_to :user
    has_many :reservations, dependent: :destroy
    validates :title, presence: true
    validates :price, presence: true, allow_nil: false



    mount_uploaders :photos, PhotosUploader
    skip_callback :commit, :after, :remove_previously_stored_avatar
    serialize :photos, JSON # If you use SQLite, add this line.    

    scope :title, -> (title) {where('title iLIKE ?', "%#{title}%")} #does the same thing as def self.search
    scope :city, -> (city) {where('city iLIKE ?', "%#{city}%")}
    scope :price, -> (min_price, max_price) {where('price >= ? AND price <= ?', min_price, max_price)}

    def self.search_title(title)
        where("title ILIKE :title", title: "%#{title}%").map do |record|
        record.title 
        end
    end 

    def self.search_city(city)
        where("city ILIKE :city", city: "%#{city}%").map do |record|
        record.city 
        end
    end 

    # :all wasn't working
    
    # def self.search(search)
    #     if search
    #         find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    #     else
    #         find(:all)
    #     end
    # end    
end