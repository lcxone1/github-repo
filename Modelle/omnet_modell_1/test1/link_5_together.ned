//5个相同class的元素串联，从第1个开始依次将1个未定义的消息发给最后一个

simple Txc12
{
    parameters:
        @display("i=block/routing");
    gates:
        inout gate[];  // declare two way connections
}

// using two way connections to further simplify the network definition
network Link5Together
{
    @display("bgb=834,519");
    types:
        channel Channel extends ned.DelayChannel
        {
            delay = 100ms;
        }
    submodules:
        tic[5]: Txc12 {

        }
    connections:
        tic[0].gate++ <--> Channel <--> tic[1].gate++;
        tic[1].gate++ <--> Channel <--> tic[2].gate++;
        tic[2].gate++ <--> Channel <--> tic[3].gate++;
        tic[3].gate++ <--> Channel <--> tic[4].gate++;

}
