+++
title = "How agents produce tokens"
weight = 2
+++

The following is a more detailed look at the process lifecycle from when your end user sends a prompt to receiving a completion.

When you start an agent, it registers itself in the balancer by starting a WebSocket connection with the balancer's Management service.

When the user sends a prompt, this generates a request received by the Inference service. The Inference service then uses the persistent WebSocket connection between the balancer and agents to send the request to the agent. During this step, the requests are also potentially buffered, and balanced across the available agents.

Next, the agent that received the request behaves as a mini balancer on its own - it sends the request to one of its available slots. 

The way slots work is that they use a model that is loaded in memory only once, and they operate on their own context and KV cache. 

Slots batch the input tokens from the incoming requests and use the underlying llama.cpp engine to sample the output tokens, and then send them back to the Management service in the balancer. 

The Management service sends the response back to the Inference service. 

Finally, the Inference service sends the output tokens back to the user.
