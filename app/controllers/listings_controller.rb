class ListingsController < ApplicationController
    # can add all sorts of before_action?
    def index                
        @listing = Listing.all

    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = current_user.listings.new(listing_params)
        if @listing.save 
            redirect_to listings_path
        else
            redirect_back(fallback_location: new_listing_path)
        end        
    end

    private

    def listing_params
        params.require(:listing).permit(:title, :user_id, :kitchen, amenities: [])
        # remember amenities will be saved in an array.
    end
end