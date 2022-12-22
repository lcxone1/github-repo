package signalsandgateways.examples.test3;
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
network test3
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
        canbus1: CanBus {
            @display("p=137,62");
        }
        sensor[4]: CanNode {
            @display("p=51,62");
        }
        canbus2: CanBus {
            @display("p=634.6,61.56");
        }
        aktor[3]: CanNode {
            @display("p=720.48,61.56");
        }
        gateway1: Gateway1 {
            @display("p=214,62");
            gates:
                cang[1];
                ethg[1];
        }

        gateway2: Gateway2 {
            @display("p=548.72003,61.56");
            gates:
                cang[1];
                ethg[1];
        }

        etherHost: EtherHost {
            @display("p=379,142");
        }
        switch1: Switch {
            @display("p=379,62");
            gates:
                ethg[3];
        }
    connections:
        //gateway1.ethg[0] <--> cable {  delay = 100ns; } <--> switch.ethg[0];
        //gateway2.ethg[0] <--> cable {  delay = 50ns; } <--> switch.ethg[1];

        gateway1.cang[0] <--> canbus1.gate++;
        gateway2.cang[0] <--> canbus2.gate++;

        for i=0..(3) {
            canbus1.gate++ <--> sensor[i].gate;
        }
        for i=0..(2) {
            canbus2.gate++ <--> aktor[i].gate;
        }

        gateway1.ethg[0] <--> Eth100M <--> switch1.ethg[0];
        switch1.ethg[1] <--> Eth100M <--> gateway2.ethg[0];
        switch1.ethg[2] <--> Eth100M <--> etherHost.ethg;
}
