module Vcloud
  module EdgeGateway
    class EdgeGatewayConfiguration

      attr_reader :config

      def initialize(local_config, remote_config, edge_gateway_interfaces)
        @config = generate_new_config(local_config, remote_config, edge_gateway_interfaces)
      end

      def update_required?
        @config.any?
      end

      private
      def generate_new_config(local_config, remote_config, edge_gateway_interfaces)
        new_config = { }

        firewall_service_config =
          EdgeGateway::ConfigurationGenerator::FirewallService.new.
            generate_fog_config(local_config[:firewall_service])

        unless firewall_service_config.nil?
          differ = EdgeGateway::FirewallConfigurationDiffer.
            new(firewall_service_config, remote_config[:FirewallService])
          unless differ.diff.empty?
            new_config[:FirewallService] = firewall_service_config
          end
        end

        nat_service_config = EdgeGateway::ConfigurationGenerator::NatService.new(
          local_config[:nat_service],
          edge_gateway_interfaces
        ).generate_fog_config

        unless nat_service_config.nil?
          differ = EdgeGateway::NatConfigurationDiffer.new(nat_service_config, remote_config[:NatService])
          unless differ.diff.empty?
            new_config[:NatService] = nat_service_config
          end
        end

        load_balancer_service_config =
          EdgeGateway::ConfigurationGenerator::LoadBalancerService.new(
            edge_gateway_interfaces
          ).generate_fog_config(local_config[:load_balancer_service])

        unless load_balancer_service_config.nil?
          differ = EdgeGateway::LoadBalancerConfigurationDiffer.new(
                     load_balancer_service_config,
                     remote_config[:LoadBalancerService]
                   )
          unless differ.diff.empty?
            new_config[:LoadBalancerService] = load_balancer_service_config
          end
        end

        new_config
      end

    end
  end
end
