require 'methadone'

module Vcloud
  module EdgeGateway
    class Application
      include Methadone::Main
      include Methadone::CLILogging

      main do |resource|
        print resource
      end

      on("--verbose", "Verbose output")
      on("--debug",   "Debugging output")
      on("--no_power_on",  "Do not power on vApps (default is to power on)")

      arg :resource

      description '
      vcloud-edge_gateway does something...

      See https://github.com/alphagov/vcloud-edge_gateway for more info'

      version Vcloud::EdgeGateway::VERSION

      go!
    end
  end
end
