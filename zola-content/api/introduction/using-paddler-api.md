+++
title = "Using Paddler API"
weight = 1
+++

Paddler is divided into two services: the Inference service and the Management service. Each service has its own API and uses a separate address.

The Inference service provides tokens and embeddings. You can send requests to the Inference service through either WebSocket or REST.

The Management service manages the whole Paddler setup (get the list of registered agents, model metadata, specify the balancer's desired state, etc.). It is managed through REST.

Although the Management service does offer a WebSocket connection, it is reserved for agents to maintain a persistent connection with the balancer. We don't document it here since it's intended only for internal use.
