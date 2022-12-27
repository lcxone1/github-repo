package signalsandgateways.examples.test_udp;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;


network test_udp
{
    parameters:
        //int numTargets = 2;
        @display("bgb=884,316");
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
        }
    submodules:
        IP_zentral: StandardHost {
            parameters:
                @display("i=device/pc3;p=486,50");
        }
        R1: Router {
            parameters:
                @display("p=486,154");
        }
        IP_1: StandardHost {
            parameters:
                @display("p=238,154;i=device/pc2");
        }
        configurator: IPv4NetworkConfigurator {
            parameters:
                config = xmldoc("config.xml");
                @display("p=62,31");
        }
        IP_2: StandardHost {
            @display("p=717,154");
        }
    connections:
        IP_1.ethg++ <--> C <--> R1.ethg++;

        R1.ethg++ <--> C <--> IP_zentral.ethg++;

        IP_2.ethg++ <--> C <--> R1.ethg++;
}
