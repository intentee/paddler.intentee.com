+++
title = "Key features"
weight = 4
+++

## Inference service
The inference service receives the user's requests with prompts and returns the responses. It is meant to be used directly by the product teams that need the AI-based features in their applications.

## Load balancer
Paddler's load balancer feature is optimized to work with LLMs and effectively use LLM-specific features like continuous batching algorithms and slots. It works by evenly distributing the incoming requests to agents that are connected directly to the balancer.

## Buffered requests
If there are no available slots in agents, Paddler will buffer the incoming requests.

By default, the maximum time the requests can spend in the buffer is 10000 milliseconds. After this time passes, all requests that were not distributed to their respective slots will timeout. You can adjust the buffering time by running the balancer with the  `--buffered-request-timeout` flag, followed by the desired time (in milliseconds).

Buffering is useful not only at the time of high traffic, but it can also be used with autoscaling groups (including scaling from zero hosts). For example, if you have an autoscaler setting up an additional server, putting the incoming requests on hold in the buffer might give them a chance to be handled even though there might be no available instance with an agent at the moment the requests were issued.

## Agents and slots
Agents are responsible for initiating the connection with the balancer via a web socket, which ensures a steady, bidirectional communication. The balancer distributes the incoming requests to the agents, which further distribute them to the available slots.

Slots are predefined memory slices within the server that handle individual requests. The concept of splitting the memory between slots comes from llama.cpp, but Paddler implements its own slots system, where the model is loaded into memory only once, and each slot maintains its own KV cache and can handle the conversations in parallel.

<div class="formatted-text__note">
    The incoming 2.1 version of Paddler will introduce a conversation based routing, allowing you to route the requests to the same KV cache to ensure context maintenance.
</div>

## Using different models
Paddler supports models in the GGUF format from two different sources:
- Hugging Face
- Local file

In addition to providing the URL or path to the model, you can modify the inference parameters and the chat template.

## Web admin panel

## StatsD metrics
