class ListingsController < ApplicationController
    # before_action :sign_in
    # can add all sorts of before_action?
    before_action :require_login, only: [:create, :edit, :update, :destroy]
    before_action :set_listing, only: [:edit, :update, :destroy]

    def index                
        @listing = Listing.all.order(:title).page params[:page]
        # @photo = photos.all
    end

    def autocomplete_title
        title_found = Listing.search_title(params["title"])
        render json: title_found
    end

    def autocomplete_city
        city_found = Listing.search_city(params["city"])
        render json: city_found
    end

    def search
        @listing = Listing.all.page params[:page]

        filtering_params(params).each do |key, value|
            @listing = @listing.public_send(key, value) if value.present?
        end

        # @listing = Listing.title(params[:title]).page params[:page] 
        # @listing = Listing.city(params[:city]).page params[:page] 
        # @listing = Listing.price(params[:min_price], params[:max_price]).page params[:page]
        render template:"listings/search"
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
            # flash[:notice] = "Sorry. You are not allowed to perform this action."
            redirect_to listings_path, notice: "Sorry. You do not have the permission to verify a property."
        elsif
            @listing = @listing.destroy
            redirect_to listings_path, notice: "You have deleted #{@listing.title}"
        end
    end

    private

    def filtering_params(params)
        params.slice(:title, :city, :price)
    end

    def listing_params
        params.require(:listing).permit(:title, :user_id, :kitchen, :price, :city, {amenities: []}, {photos: []})
        # remember amenities will be saved in an array.
    end

    def set_listing
        @listing = Listing.find(params[:id])
    end

    def sign_in
        unless current_user
            redirect_to sign_in_path
        end
    end
end