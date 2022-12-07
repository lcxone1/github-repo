//5个不同class的元素串联，从第1个开始依次将1个未定义的消息发给最后一个

simple Test1_Class
{
    parameters:
        bool sendMsgOnInit = default(false);
    gates:
        inout gate[];  // declare two way connections
}


simple Sensor extends Test1_Class
{
    parameters:
        sendMsgOnInit = true;
}


simple Aktor extends Test1_Class
{
}

simple Gateway extends Test1_Class
{
}

simple IP extends Test1_Class
{
}

// using two way connections to further simplify the network definition
network Link5TogetherWithClasse
{
    //@display("bgb=834,519");
    types:
        channel Channel extends ned.DelayChannel
        {
            delay = 100ms;
        }
    submodules:
        sensor1: Sensor;
        aktor1: Aktor;
        gw1: Gateway;
        gw2: Gateway;
        ip1: IP;
    connections:
        sensor1.gate++ <--> Channel <--> gw1.gate++;
        gw1.gate++ <--> Channel <--> ip1.gate++;
        ip1.gate++ <--> Channel <--> gw2.gate++;
        gw2.gate++ <--> Channel <--> aktor1.gate++;

}
