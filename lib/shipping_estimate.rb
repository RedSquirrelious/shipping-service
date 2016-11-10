class ShippingEstimate
	attr_accessor :carrier_name, :carrier_service, :rate, :carrier_service_code

	def initialize(options)
		@carrier_service = options.service_name
		@carrier_rate = options.total_price
		@carrier_service_code = options.service_code
	end

end