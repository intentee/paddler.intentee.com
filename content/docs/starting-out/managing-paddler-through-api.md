+++
title = "Managing Paddler through API"
weight = 7
+++

API documentation is [here](@/api/introduction/using-paddler-api.md).

You can manage your entire Paddler setup (using Management service) and connect to Paddler to generate tokens and embeddings (using Inference service) via API.

Requests to the Inference service can be sent through either WebSocket or REST.

The Management service can be managed through REST. 

Although the Management service does offer a WebSocket connection, it is reserved for agents to maintain a persistent connection with the balancer.
