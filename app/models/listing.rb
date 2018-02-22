class Listing < ApplicationRecord
    belongs_to :user
    validates :title, presence: true

    mount_uploaders :photos, AvatarUploader
    serialize :photos, JSON # If you use SQLite, add this line.    
end