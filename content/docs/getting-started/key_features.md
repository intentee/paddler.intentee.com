+++
title = "Key features"
weight = 4
+++

Paddler is a complete LLMOps platform for inference and self-hosting of LLMs at scale. Its key features include:

## Inference service
The inference service receives the user's requests with prompts and returns the responses. It is meant to be used directly by the product teams that need the AI-based features in their applications.

## Using different models
You can use different models with Paddler, provided they are in the GGUF format. Paddler supports two different model sources: Hugging Face and local files. Additionally, Paddler allows you adjust the inference parameters and the chat template for the selected model.

## Load balancer
Paddler's load balancer feature is optimized to work with LLMs and effectively uses LLM-specific features like continuous batching algorithms and slots. The balancer is responsible for distributing the incoming requests to the agents connected to it.

## Agents and slots
Agents are connected to the load balancer and are further divided into slots. A slot is a predefined memory allocation within the server that handles individual requests. Paddler's implementation of slots comes with each slot maintaining its own KV cache and being able to handle the conversations in parallel.

## Buffered requests
If there are no available slots in agents, Paddler will buffer the incoming requests. Buffering is useful not only during periods of high traffic, but it can also be used with autoscaling groups, allowing your infrastructure to scale from zero hosts.

## Web admin panel
The web admin panel is a convenient way to manage your Paddler instance. It allows you to monitor the status of the agents, slots usage, and the buffered requests. You can also use the admin panel to provide the model source, as well as adjust the inference parameters and chat template for the selected model.

## StatsD metrics
Paddler provides a handful of useful metrics in the StatsD format.
