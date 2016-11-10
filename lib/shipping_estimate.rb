class ShippingEstimate
	attr_accessor :carrier_name, :carrier_service, :rate

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

	def initialize(packages, origin, destination)
		# @carrier_name = details[:carrier]
		# @carrier_service = details[:carrier_service]
		# @carrier_rate = details[:carrier_rate]
	
		@packages = packages
		@origin = origin
		@destination = destination

	end

	def find_UPS_costs
		ups = ActiveShipping::UPS.new(login: UPS_LOGIN, password: UPS_PW, key: UPS_KEY)

 		response = ups.find_rates(ShippingMethodsController.define_origin, ShippingMethodsController.define_destination, ShippingMethodsController.pack_box)

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



end