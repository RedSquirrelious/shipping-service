require 'shipping_option'

class ShippingMethodsController < ApplicationController
  UPS_LOGIN = ENV["ACTIVESHIPPING_UPS_LOGIN"]
	UPS_PW = ENV["ACTIVESHIPPING_UPS_PASSWORD"]
	UPS_KEY = ENV["ACTIVESHIPPING_UPS_KEY"]

		# BASE_URL = 
	COUNTRY = 'US'
	ORIGIN_ZIP = 98161
	DESTINATION_ZIP = 99518
	
	WEIGHT = 10
	UNITS = {units: :imperial}
	DIMENSIONS = [12, 12, 12]
# /CONSTANTS

	def pack_box
		# @packages = ActiveShipping::Package.new((WEIGHT * 16), DIMENSIONS, UNITS)

		@packages = ActiveShipping::Package.new((WEIGHT * 16), DIMENSIONS, UNITS)
	end

	def define_origin
		@origin = ActiveShipping::Location.new(country: COUNTRY, zip: ORIGIN_ZIP)
	end

	def define_destination
		@destination = ActiveShipping::Location.new(country: COUNTRY, zip: DESTINATION_ZIP)
	end


  def index
  	option = ShippingEstimate.new(pack_box, define_origin, define_destination)
  	# raise
  	# puts option.inspect
 
  	response = option.find_UPS_costs
  	# Binding.pry
  	# render json: JSON.pretty_generate(response)
  	render json: response
  end

  def show
  end

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

	# def find_UPS_costs
	# 	ups = ActiveShipping::UPS.new(login: UPS_LOGIN, password: UPS_PW, key: UPS_KEY)
 
 # 		response = ups.find_rates(define_origin, define_destination, pack_box)

 # 		render json: response
	# end

end
