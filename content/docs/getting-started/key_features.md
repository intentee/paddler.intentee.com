+++
title = "Key features"
weight = 4
+++

Paddler is a complete LLMOps platform for inference and self-hosting of LLMs at scale. Its key features include:

## Inference service
The inference service receives the user's requests with either individual prompts or the whole conversation history, and then sends back the response with generated tokens to the user. It is meant to be used directly by the product teams that need the AI-based features in their applications.

## Using models
Paddler supports using models in the GGUF format. You can use two different sources for providing the model: Hugging Face and local files. Additionally, Paddler allows you adjust the inference parameters and the chat template for the selected model.

## Load balancer
Paddler's load balancer feature is optimized to work with LLM-specific features like continous batching algorithm and slots. It works by distributing the incoming requests to the agents connected to it.

## Agents and slots
Agents are connected to the load balancer and further distribute the incoming requests among slots. A slot is a separate thread within the agent that manages its own context and KV cache, and allows for handling the conversations in parallel.

## Buffered requests
If there are no available slots in agents, Paddler will buffer the incoming requests. Buffering is useful not only during periods of high traffic, but it can also be used with autoscaling groups, allowing your infrastructure to scale from zero hosts.

## Web admin panel
The web admin panel is a convenient way to manage your Paddler instance. It allows you to monitor the status of the agents, slots usage, and the buffered requests. You can also use the admin panel to provide the model source, as well as adjust the inference parameters and chat template for the selected model.

## StatsD metrics
Paddler provides a handful of useful metrics in the StatsD format to help you further monitor your Paddler fleets.
