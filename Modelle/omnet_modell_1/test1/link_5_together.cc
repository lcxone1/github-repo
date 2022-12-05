







//5个相同class的元素串联，从第1个开始依次将1个未定义的消息发给最后一个
#include <stdio.h>
#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

/**
 * Let's make it more interesting by using several (n) `tic' modules,
 * and connecting every module to every other. For now, let's keep it
 * simple what they do: module 0 generates a message, and the others
 * keep tossing it around in random directions until it arrives at
 * module 2.
 */
class Txc12 : public cSimpleModule
{
  protected:
    virtual void forwardMessage(cMessage *msg);
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(Txc12);

void Txc12::initialize()
{
    if (getIndex() == 0) {
        // Boot the process scheduling the initial message as a self-message.
        char msgname[20];
        sprintf(msgname, "tic-%d", getIndex());
        cMessage *msg = new cMessage(msgname);
        scheduleAt(0.0, msg);
    }
}

void Txc12::handleMessage(cMessage *msg)
{
    if (getIndex() == 4) {
        // Message arrived.
        EV << "Message " << msg << " arrived.\n";
        delete msg;
    }
    else if (getIndex() == 0){
        send(msg, "gate$o", 0);//0 means first gate (gate nach links)
    }
    else {
        // We need to forward the message.
        forwardMessage(msg);
    }
}

void Txc12::forwardMessage(cMessage *msg){
    // In this example, we just pick a random gate to send it on.
    // We draw a random number between 0 and the size of gate `gate[]'.
    //int n = gateSize("gate");
    //int k = intuniform(0, n-1);

    // $o and $i suffix is used to identify the input/output part of a two way gate
    send(msg, "gate$o", 1);  //1 means second gate (gate nach rechts)
    //EV<<"send msg to "<<k<<"\n";
}
