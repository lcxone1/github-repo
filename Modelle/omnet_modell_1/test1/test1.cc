//5个不同class的元素串联，从第1个开始依次将1个未定义的消息发给最后一个
#include <stdio.h>
#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

/**
 * Let's make it more interesting by using several (n) `tic' modules,
 * and connecting every module to every other. For now, let's keep it
 * simple what they do: module 0 generates a message, and the others
 * keep tossing it around in random directions until it arrives at
 * module 3.
 */
class Test1_Class : public cSimpleModule
{
  protected:
    virtual void forwardMessage(cMessage *msg);
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(Test1_Class);

void Test1_Class::initialize()
{
    if (strcmp("sensor1", getName()) == 0) {

        EV << "Sending initial message from sensor\n";
        cMessage *msg = new cMessage("TestMsg");
        scheduleAt(0.0, msg);
    }
}

void Test1_Class::handleMessage(cMessage *msg)
{
    if (strcmp("aktor1", getName()) == 0) {
            // Message arrived.
            EV << "Message " << msg << " arrived at aktor, delete message.\n";
            delete msg;
    }
    else if (strcmp("sensor1", getName()) == 0){
        send(msg, "gate$o", 0);
    }
    else{
        forwardMessage(msg);
    }
}

void Test1_Class::forwardMessage(cMessage *msg)
{

    send(msg, "gate$o", 1);
}
