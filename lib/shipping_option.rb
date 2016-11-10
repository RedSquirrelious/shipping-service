require 'active_shipping'
require 'shipping_estimate'

# THIS CLASS USES THE GEM ACTIVE SHIPPING TO CALL ON SHIPPER APIS FOR SHIPPING PRICES/TIMES

class ShippingOption

	attr_reader

#CONSTANTS
#hide that information away!
	UPS_LOGIN = ENV["ACTIVESHIPPING_UPS_LOGIN"]
	UPS_PW = ENV["ACTIVESHIPPING_UPS_PASSWORD"]
	UPS_KEY = ENV["ACTIVESHIPPING_UPS_KEY"]

	USPS_LOGIN = ENV["ACTIVESHIPPING_USPS_LOGIN"]

	# BASE_URL = 
	COUNTRY = 'US'
	ORIGIN_ZIP = 98161
	DESTINATION_ZIP = 99518
	
	WEIGHT = 10
	UNITS = {units: :imperial}
	DIMENSIONS = [12, 12, 12]
# /CONSTANTS

	def pack_box
		@packages = ActiveShipping::Package.new((WEIGHT * 16), DIMENSIONS, UNITS)
		# @packages = ActiveShipping::Package.new(WEIGHT, DIMENSIONS, UNITS)
	end

	def define_origin
		@origin = ActiveShipping::Location.new(country: COUNTRY, zip: ORIGIN_ZIP)
	end

	def define_destination
		@destination = ActiveShipping::Location.new(country: COUNTRY, zip: DESTINATION_ZIP)
	end


# CREATE A WRAPPER 
	def initialize
		@packages = pack_box
		@origin = define_origin
		@destination = define_destination
	end



	def find_UPS_costs
		ups = ActiveShipping::UPS.new(login: UPS_LOGIN, password: UPS_PW, key: UPS_KEY)
 		response = ups.find_rates(define_origin, define_destination, pack_box)

 		options = []

 		response.rates.each do |shipping_option|
 			details = {}
 			details[:carrier_service] = shipping_option.service_name
 			details[:carrier_rate] = shipping_option.price
 			estimate = ShippingEstimate.new(details)

 			# estimate = ShippingEstimate.new(shipping_option)
 			options << estimate
 		end

 		return options

 #  usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}


	end

	# def self.find_USPS_costs(origin, destination, packages)
	# 	usps = ActiveShipping::USPS.new(login: USPS_LOGIN)
 
 # 		response = usps.find_rates(define_origin, define_destination, pack_box)

 # 		render json: response
	# end




# # Package up a poster and a Wii for your nephew.
# packages = [
#   ActiveShipping::Package.new(100,               # 100 grams
#                               [93,10],           # 93 cm long, 10 cm diameter
#                               cylinder: true),   # cylinders have different volume calculations

#   ActiveShipping::Package.new(7.5 * 16,          # 7.5 lbs, times 16 oz/lb.
#                               [15, 10, 4.5],     # 15x10x4.5 inches
#                               units: :imperial)  # not grams, not centimetres
#  ]

#  # You live in Beverly Hills, he lives in Ottawa
#  origin = ActiveShipping::Location.new(country: 'US',
#                                        state: 'CA',
#                                        city: 'Beverly Hills',
#                                        zip: '90210')

#  destination = ActiveShipping::Location.new(country: 'CA',
#                                             province: 'ON',
#                                             city: 'Ottawa',
#                                             postal_code: 'K1P 1J1')

#  # Find out how much it'll be.
#  ups = ActiveShipping::UPS.new(login: 'auntjudy', password: 'secret', key: 'xml-access-key')
#  response = ups.find_rates(origin, destination, packages)

#  ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
#  # => [["UPS Standard", 3936],
#  #     ["UPS Worldwide Expedited", 8682],
#  #     ["UPS Saver", 9348],
#  #     ["UPS Express", 9702],
#  #     ["UPS Worldwide Express Plus", 14502]]

#  # Check out USPS for comparison...
#  usps = ActiveShipping::USPS.new(login: 'developer-key')
#  response = usps.find_rates(origin, destination, packages)

#  usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
#  # => [["USPS Priority Mail International", 4110],
#  #     ["USPS Express Mail International (EMS)", 5750],
#  #     ["USPS Global Express Guaranteed Non-Document Non-Rectangular", 9400],
#  #     ["USPS GXG Envelopes", 9400],
#  #     ["USPS Global Express Guaranteed Non-Document Rectangular", 9400],
#  #     ["USPS Global Express Guaranteed", 9400]]

end
