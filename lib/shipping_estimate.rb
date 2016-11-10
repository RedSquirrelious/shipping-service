class ShippingEstimate
	attr_accessor :carrier_name, :carrier_service, :rate

	def initialize(details)
		@carrier_name = details[:carrier]
		@carrier_service = details[:carrier_service]
		@carrier_rate = details[:carrier_rate]
	end
end