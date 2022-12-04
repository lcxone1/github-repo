%% Establish Message Send and Receive Interfaces Between Software Components
% This example shows how to model message-based communication between
% software components that run in different applications. The example
% also shows how to prepare model components for C++ code generation. 
%
% In this example, the message-based communication is constructed between
% two components. Send component sends data and receive component consumes
% data. In this scenario, after send component sends messages, they are
% stored in a queue. Receive component pulls a message based on the logic
% it represents.
%%
model = 'MessageSendReceiveDefaultBufferModel';
open_system(model);
%% 
% Two Model blocks, labeled Send Component and Receive Component, represent
% the components connected by a message line. Message-based communication
% is achieved using a Send block and a Receive block that are connected to
% the root-level Outport and Inport blocks. 
%
% For more information about generating C or C++ code for the model,
% see <docid:ecoder_ug#mw_25731e9c-2717-4ea5-87da-593af7ccd16f_1> and
% <docid:ecoder_ug#mw_25731e9c-2717-4ea5-87da-593af7ccd16f>.
%
% You can also generate C++ code for each component, and the code contains
% necessary software interfaces that are sufficient for you to connect with
% an operating system or message middleware. For more information, see
% <docid:ecoder_ug#mw_b3d60f69-2274-4ed5-81df-b0842cd23062>. 
% 
% Copyright 2019 The MathWorks, Inc.

%% Send Component 
% The algorithm in the Send Component can contain logic of any complexity.
% In the example, a simple Sine Wave block is used in a subsystem as the
% signal source. The *Sample time* parameter of the block is set to |0.1|.
%
% <<../messages_ex_sendreceive_basicmodel1.png>>
%
% To prepare the Send Component for message-based communication, a
% <docid:simulink_ref#bucsbui-1 Send> block is connected to the root-level
% Outport block. The Send block converts data signals and send messages.
%
% To prepare the Send Component for code generation, in the Model
% Configuration Parameters:
%
% # In the *Solver* pane, in the *Solver selection* section, the *Type* is
% set to |Fixed-step|.
% # The *Fixed-step size* is set to |0.1|.
% # In the *Code Generation* pane, the *System target file* is set to
% |ert.tlc| and *Language* to C++.
% # The model is saved as |mSend|.
%% Receive Component
% In the Receive Component, a Scope block is used to represent the
% algorithm that receives messages.
%
% To prepare the Receive Component, the Inport block is connected to a
% <docid:simulink_ref#bucscsk-1 Receive> block. The Receive block receives
% messages and converts them to signal data. By default, the *Sample time*
% parameter of the Receive block is |-1|.
% 
% <<../messages_ex_sendreceive_basicmodel4.png>>
%
% To prepare the Receive Component for code generation, in the Model
% Configuration Parameters:
%
% # In the *Solver* pane, in the *Solver selection* section, the *Type* is
% set to |Fixed-step|.
% # The *Fixed-step size* is set to |0.1|.
% # In the *Code Generation* pane, the *System target file* is set to
% |ert.tlc| and *Language* to C++.
% # The model is saved as |mReceive|.
%% Visualize Message Transitions Between Components Using the Sequence Viewer Block
% This is a composition model with Send and Receive components. The Model
% blocks, Send Component and Receive Component, refer to models |mSend| and
% |mReceive|, respectively.
%
% Simulate the model. Observe the queue inserted by default. An icon above
% the message line represents the default queue. The capacity of the
% default queue is |1| and the message overwriting policy is enabled. You
% can customize the queue by using a Queue block between components. For
% more information, see
% <docid:simulink_ug#mw_ef884c98-4fb0-48d5-af25-b0e6c0712db5>.
% 
% <<../messages_ex_sendreceive_defaultqueue.png>>
%
% Open the <docid:simulink_ref#buc4bm_-1 Sequence Viewer> block. The block
% allows you to visualize message transition events and the data that the
% messages carry.
%
% The Sequence Viewer block window shows the simulation time in the left
% vertical bar. Each time grid row contains events that occur at the same
% simulation time. Each message transition event is represented by an arrow
% that is labeled with the message data value. For more information about
% the Sequence Viewer block, see <docid:simulink_ug#bujbicr-2>.
%
% In the Sequence Viewer block, scroll up or click *Go to first event* icon
% on the left. Observe that at time zero the Send block sends a message
% with data value |0| to the Receive block, and at time |0.1| the block
% sends another message with data value |0.0998|. The block sends a
% message in every |0.1| simulation time.
%
% <<../messages_ex_sendreceive_seqviewer.png>>