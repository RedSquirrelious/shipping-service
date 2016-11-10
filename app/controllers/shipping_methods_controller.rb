require 'shipping_option'

class ShippingMethodsController < ApplicationController

  UPS_LOGIN = ENV["ACTIVESHIPPING_UPS_LOGIN"]
	UPS_PW = ENV["ACTIVESHIPPING_UPS_PASSWORD"]
	UPS_KEY = ENV["ACTIVESHIPPING_UPS_KEY"]

		# BASE_URL = 
	COUNTRY = 'US'
	ORIGIN_ZIP = 99518
	DESTINATION_ZIP = 98110
	
	WEIGHT = 10
	UNITS = {units: :imperial}
	DIMENSIONS = [12, 12, 12]
# /CONSTANTS

# GOAL:  THE GOAL HERE IS TO KEEP DATA AWAY FROM THE API METHOD
	def pack_box
		# @packages = ActiveShipping::Package.new((WEIGHT * 16), DIMENSIONS, UNITS)
		@packages = ActiveShipping::Package.new((WEIGHT * 16), DIMENSIONS, UNITS)
	end

	def define_origin
		# @origin = ActiveShipping::Location.new(country: COUNTRY, zip: ORIGIN_ZIP)
		@origin = ActiveShipping::Location.new(country: COUNTRY, zip: ORIGIN_ZIP)
	end

	def define_destination
		# @destination = ActiveShipping::Location.new(country: COUNTRY, zip: DESTINATION_ZIP)
		@destination = ActiveShipping::Location.new(country: COUNTRY, zip: DESTINATION_ZIP)
	end
# /GOAL

  def index	
		response = ShippingMethodsController.find_UPS_costs(pack_box, define_origin, define_destination)
  	render json: response
  end



	def self.find_UPS_costs(pack_box, define_origin, define_destination)
		ups = ActiveShipping::UPS.new(login: UPS_LOGIN, password: UPS_PW, key: UPS_KEY)

 		response = ups.find_rates(define_origin, define_destination, pack_box)

 		options = []

 		response.rates.each do |shipping_option|
 			estimate = ShippingEstimate.new(shipping_option)
 			options << estimate
 		end

 		return options

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
