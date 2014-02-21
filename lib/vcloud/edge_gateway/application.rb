require 'methadone'

module Vcloud
  module EdgeGateway
    class Application
      include Methadone::Main
      include Methadone::CLILogging

      main do |resource|
        print resource
      end

      on("-d", "--diff",  "Diff between passed in config and remote config")

      arg :resource

      description '
      vcloud-edge_gateway does something...

      See https://github.com/alphagov/vcloud-edge_gateway for more info'

      version Vcloud::EdgeGateway::VERSION

      go!
    end
  end
end
