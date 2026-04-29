+++
description = "Discover in detail how Paddler works internally by following the flow from the moment your user sends a prompt to the moment they receive a completion."
layout = "LayoutDocumentationPage"
title = "How Paddler works"

[[collection]]
name = "documentation_pages"
parent = "docs/internals/index"
+++

The following is a more detailed look at how Paddler works, from the moment your user sends a prompt to the moment they receive a completion.

## Paddler components

Paddler consists of two main components, the `balancer`, and the `agents`. 

The `balancer` exposes the following:
- Inference service, which has direct contact with your application. When the user sends their prompt, it is received by the Inference service, and similarly, it is the Inference service that sends the output tokens back to the user.
- Management service, which manages the Paddler's setup internally (has a persistent connection with the agents, sends them commands, load balances the requests, etc.).

Balancer also exposes the Web admin panel, which you can use to preview and test your Paddler setup.

## The flow

<Figure 
    alt="How Paddler works"
    src="resources/media/how-paddler-works/how-paddler-works.avif"
/>

### Registering agents

When you start an agent, it registers itself in the balancer by starting a WebSocket connection with the balancer's Management service.

### Distributing requests to agents

When a user sends a prompt, it is sent to the Inference service in the balancer. The Inference service then uses the persistent WebSocket connection between the balancer and agents to send the request to the agent. During this step, the requests are also potentially buffered, and balanced across the available agents.

### Processing the request by the agent

Once the request reaches the agent, the agent assigns it to one of its available slots. A slot represents one concurrent request the agent can handle. You can set how many slots an agent has with the `--slots` flag.

### Token processing and generation by the agent

The agent loads the model and its llama.cpp context once, and all slots share them. A scheduler inside the agent uses continuous batching to process all active slots together in a single forward pass, stepping each slot, whether it is still ingesting its prompt or already generating output tokens.

Each slot is identified by a unique sequence ID — a unique number identifying the request inside the shared context. The agent uses the sequence ID to keep every request's tokens separate, even when many requests are processed together. As soon as a request finishes, its slot is freed for the next one.

### Sending the response back to the user

When the agent generates the output tokens, they get sent back to the Management service in the balancer, that further sends them to the Inference service.

Finally, the Inference service sends the output tokens back to the user in the response.
