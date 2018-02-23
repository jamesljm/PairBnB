class Listing < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    validates :title, presence: true

    mount_uploaders :photos, AvatarUploader
    serialize :photos, JSON # If you use SQLite, add this line.    

    scope :search, -> (search) {where('title iLIKE ?', "%#{search}%")} #does the same thing as def self.search

    # :all wasn't working
    
    # def self.search(search)
    #     if search
    #         find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    #     else
    #         find(:all)
    #     end
    # end    
end