+++
title = "How Paddler works"
weight = 1
+++

The following is a more detailed look at how Paddler works, from the moment your user sends a prompt to the moment they receive a completion.

## Paddler components

Paddler is made of two main components, the `balancer`, and the `agents`. 

The `balancer` exposes the following:
- Inference service, which has direct contact with your application. When the user sends their prompt, it is received by the Inference service, and similarly, it is the Inference service that sends the output tokens back to the user.
- Management service,  which manages the Paddler's setup internally (has a persistent connection with the agents, sends them commands, load balances the requests, etc.).

Balancer also exposes the Web admin panel, which you can use to preview and test your Paddler setup.

## The flow

{{ figure_image(path="how-paddler-works.avif", alt="How Paddler works") }}

### Registering agents

When you start an agent, it registers itself in the balancer by starting a WebSocket connection with the balancer's Management service.

### Distributing requests to agents

When a user sends a prompt, it is sent to the Inference service in the balancer. The Inference service then uses the persistent WebSocket connection between the balancer and agents to send the request to the agent. During this step, the requests are also potentially buffered, and balanced across the available agents.

### Processign the request by the agent

Once the request is sent to the appropriate agent, the agent behaves as a mini balancer on its own - it sends the request to one of its available slots. 

### Token processing and generation by the slot

The way slots work is that they use a model that is loaded in memory only once, and they operate on their own context and KV cache. 

Slots batch the input tokens from the incoming requests and use the underlying llama.cpp engine to sample the output tokens, and then send them back to the Management service in the balancer. 

### Sending the response back to the user

When the slot generates the output tokens, they get sent back to The Management service in the balancer, that further sends sends them to the Inference service. 

Finally, the Inference service sends the output tokens back to the user in the response.
