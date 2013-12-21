module Downloader

	def self.process(file_name)
		# check that the file exists
		return false if !File.exists?("#{Controller::NGINX_ROOT}/files/#{file_name}")

		# check for access if validation is required

		# note the download attempt in the database
		puts "allowing download of #{file_name}"
	end
end