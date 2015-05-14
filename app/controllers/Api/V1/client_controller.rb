module Api
  module V1
    class ClientController < ApplicationController
    	skip_before_action :authenticate_user_from_token!, only: [:create]
    	def index
    		@client = Client.all

    		render json: @client
    	end

	    def create
	      @client = Client.new client_params

	      if @client.save
	        render json: @client
	      else
	        render json: { error: t('client_create_error') }, status: :unprocessable_entity
	      end
	    end

	    private

	    def client_params
	      params.require(:client).permit(:email, :username, :password, :password_confirmation)
	    end
    end
  end
end