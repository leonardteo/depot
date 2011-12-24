class StoreController < ApplicationController
  
  skip_before_filter :authorize
  
  #The main store homepage
  def index

  	#Redirect if we have a locale set
  	if params[:set_locale]
  		redirect_to store_path(locale: params[:set_locale])
	else
    
    	#Get all products and order by title
    	@products = Product.order(:title)
    	@cart = current_cart
    end
    
  end

end
