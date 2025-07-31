+++
title = "Key features"
weight = 4
+++

Paddler is a complete LLMOps platform for inference and self-hosting of LLMs at scale. Its key features include:

## Inference
Paddler exposes WebSocket and HTTP REST APIs that are able to respond with generated tokens based either on a single raw prompt or a continued chat history.

It is possible to customize the chat template, system prompt, and other inference parameters directly in Paddler.

The inference service is meant to be used by the product teams that need the AI-based features in their applications.

## Models Support
Paddler uses `llama.cpp` internally, so it supports the same models as `llama.cpp` does.

In general, you can use any LLM in the GGUF format. You can do so either by providing a link to the model in the GGUF format on Hugging Face or by directly providing a local file path for an agent to use.

## Load Balancing
Paddler's load balancer distributes the inference requests between all agents, taking into account the conversation history (for better caching), and the overall load of the agent.

## Paddler Agents
Paddler Agents connect to the load balancer and take commands from it. Agents are responsible for further distributing the incoming requests among slots and for generating tokens and embedding.

A slot is a separate thread within the agent that manages its own llama.cpp model's context and KV cache, and allows for handling the conversations in parallel.

Agents are designed to be easy to deploy, encapsulate `llama.cpp`, and they are the secret sauce that enables Paddler to deliver scalable services.


## Buffered requests
If there are no available slots in agents, Paddler will buffer the incoming requests. Buffering is useful not only during periods of high traffic, but it can also be used with autoscaling groups, allowing your infrastructure to scale from zero hosts.

## Web admin panel
The web admin panel is a convenient way to manage your Paddler instance. It allows you to monitor the status of the agents, slots usage, and the buffered requests. You can also use the admin panel to provide the model source, as well as adjust the inference parameters and chat template for the selected model.

## StatsD metrics
Paddler provides a handful of useful metrics in the StatsD format to help you further monitor your Paddler fleets.
