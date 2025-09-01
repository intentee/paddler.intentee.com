+++
layout = "LayoutDocumentationPage"
title = "Managing Paddler through API"

[[collection]]
after = "docs/starting-out/running-the-balancer-with-state-database"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

API documentation is [here](api/introduction/using-paddler-api).

You can manage your entire Paddler setup (using Management service) and connect to Paddler to generate tokens and embeddings (using Inference service) via API.

Requests to the Inference service can be sent through either WebSocket or REST.

The Management service can be managed through REST. 

Although the Management service does offer a WebSocket connection, it is reserved for agents to maintain a persistent connection with the balancer.
