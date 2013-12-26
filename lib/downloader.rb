module Downloader

	def self.process(file_name)
		# check that the file exists
		return false, "not_found" if !File.exists?("#{Cfg::NGINX_PATH}/files/#{file_name}")

		# check for access if validation is required

		# note the download attempt in the database
		puts "allowing download of #{file_name}"

		return true, nil
	end
end