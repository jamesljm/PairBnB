class ListingsController < ApplicationController
    # can add all sorts of before_action?
    before_action :require_login, only: [:create, :edit, :update, :destroy]
    before_action :set_listing, only: [:edit, :update, :destroy]

    def index                
        @listing = Listing.all.order(:title).page params[:page]
        # @photo = photos.all
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

    def edit
    end

    def update
        @listing = @listing.update(listing_params)
        redirect_to listings_path
    end

    def destroy
        if current_user.customer?
            flash[:notice] = "Sorry. You are not allowed to perform this action."
            redirect_to listings_path, notice: "Sorry. You do not have the permission to verify a property."
        elsif
            @listing = @listing.destroy
            redirect_to listings_path, notice: "You have deleted #{@listing.title}"
        end
    end

    private

    def listing_params
        params.require(:listing).permit(:title, :user_id, :kitchen, {amenities: []}, {photos: []})
        # remember amenities will be saved in an array.
    end

    def set_listing
        @listing = Listing.find(params[:id])
    end
end