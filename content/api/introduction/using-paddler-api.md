+++
title = "Using Paddler API"
weight = 1
+++

Paddler is divided into two services: the Inference service and the Management service. Each service has its own API and uses a separate address.

Inference service is used to obtain tokens and embeddings. Requests to the Inference service can be sent either through WebSocket or REST.

Management service is used to manage the whole Paddler setup (get the list of registered agents, model metadata, specify the balancer's desired state, etc.). It is managed through REST.

Although the Management service does offer a WebSocket connection, it is reserved for agents to maintain a persistent connection with the balancer.
