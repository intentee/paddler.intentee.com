+++
layout = "LayoutDocumentationPage"
title = "For ops teams"

[[collection]]
name = "documentation_pages"
parent = "docs/paddler-in-your-project/index"
+++

Paddler is self-contained in a single binary, which contains both `balancer` and `agent` functionalities.

**TL;DR** As an overview:

- The balancer exposes:
    - Inference service (by default on port `8061`) - generates tokens, embeddings, and other inference-related tasks (to be used by the product teams)
    - Management service (by default on port `8060`) - needs to be protected and accessed only internally; allows to swap models, manage agents, etc
    - Optionally: web admin panel (by default on port `8062`)
- The agents expose no APIs, need only an egress connection to the management service

Let's go through each of them.

## Balancer

### Inference Service

External applications use the Inference service to obtain tokens or embeddings. Expose this service to your product team so that they can use Paddler for inference in their AI-based features.

### Management Service

Management service is what controls the whole Paddler setup. Agents establish a connection with it to receive commands, and it also manages other aspects of Paddler, like load balancing or buffering requests through its internal API.

### Web admin panel

Running the web admin panel is optional, but it gives a convenient way to view and test your Paddler setup, manage the models, and observe any potential issues.

Because the web admin panel shows the status of basically everything in your Paddler setup, it needs to be able to have access to the Management service, Inference service, and the Agents.

## Agents

Agents need to be able to reach the Management service to be able to establish a WebSocket connection with it. This is why you deploy them by providing the Management service address and port. 

Ideally, you deploy each agent on its own separate server and give each agent a certain number of slots it can work with. The number of slots is the number of concurrent requests that the agent can handle. You can do some benchmarking to determine how many you need. Start with a small number, like 4 or 8.

<Note>
    If there is more than one agent deployed on the same server, they can run into some issues, like not being able to acquire a download lock for a model (since all the agents will try to download a model into the same cache), etc.

    Generally, Paddler can recover from such issues, but it's still better to avoid them.
</Note>
