package signalsandgateways.examples.test_eth;
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
//
//package signalsandgateways.examples;


import inet.linklayer.ethernet.EtherBus;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherHost;
import signalsandgateways.BusEthernetGateway;
import fico4omnet.bus.can.CanBus;
import fico4omnet.nodes.can.CanNode;

//
// Small sample network with three hosts and one switch that shows how to 
// configure the TTEthernet Model. Configuration in omnetpp.ini
// - Uses 5ms Cycletime
// - 80ns Tick length
//
network test_eth
{
    parameters:
        @display("bgb=755.44,231.04001,white");
    types:
        //
        // All links are configured with 100MBit per second and variable delay
        //
        channel cable extends ned.DatarateChannel
        {
            datarate = 100Mbps;
            //bit error rate (probability (0.0-1.0) per bit)  
            ber = 0;
            //packet error rate (probability (0.0-1.0) per packet)  
            per = 0;
        }

    submodules:
        switch1: Switch {
            @display("p=379,62");
            gates:
                ethg[3];
        }

        IP_zentral: IP {
            @display("p=379,169");
        }

        IP_1: IP {
            @display("p=228,62");
        }

        IP_2: IP {
            @display("p=519,62");
        }
    connections:
		switch1.ethg[0] <--> Eth100M <--> IP_1.ethg;
		switch1.ethg[1] <--> Eth100M <--> IP_2.ethg;
        switch1.ethg[2] <--> Eth100M <--> IP_zentral.ethg;
}
