module Cartero
	module DB
		def self.start
			case RUBY_PLATFORM
			when /linux|darwin/
				mongod = "mongod --fork"
				$stdout.puts "Launching mongodb"
				system( mongod + " --dbpath=" + Cartero::MongoDBDir + " --logpath=" + Cartero::LogsDir + "/mongodb.log" + " --logappend" + "> /dev/null")
				sleep(1)
			when /mingw|mswin/
				$stdout.puts "TODO: Manual Launch. !!! Make sure mongodb is running. !!!"
				sleep(1)
			end
		rescue
			$stderr.puts "Something went wrong starting db"
			exit(0)
		end

		def self.stop
			$stdout.puts "Stopping Mongodb"
			MongoMapper.connection['admin'].command(:shutdown => 1)
			$stdout.puts "" if RUBY_PLATFORM =~ /mingw|mswin/
		rescue StandardError => e
			$stderr.puts "Looks like there is nothing to shutdown. !!! #{e} !!!"
		end
	end
end