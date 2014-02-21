require 'methadone'

module Vcloud
  module EdgeGateway
    class Application
      include Methadone::Main
      include Methadone::CLILogging

      main do |config_file|
        EdgeGatewayServices.new.update(config_file)
      end

      on("-d", "--diff",  "Diff between passed in config and remote config")

      arg :resource

      description '
      vcloud-edge_gateway allows you to configure an Edge Gateway with an input file.

      See https://github.com/alphagov/vcloud-edge_gateway for more info'

      version Vcloud::EdgeGateway::VERSION

      go!
    end
  end
end
