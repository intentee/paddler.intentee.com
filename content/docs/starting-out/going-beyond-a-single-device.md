+++
description = "Set up a multi-agent fleet across multiple devices."
layout = "LayoutDocumentationPage"
title = "Going beyond a single device"

[[collection]]
after = "docs/starting-out/multi-agent-fleet"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

So far, we've started a Paddler fleet with multiple agents, but everything was set up locally on a single device. Now let's set up a multi-agent fleet across multiple devices.

## Starting the balancer

As before, we will start the balancer with the Inference service and the Management service. They need to run on the same device, but on different network interfaces.

The Inference service should be exposed externally, because it needs to be reachable by products and applications that send requests to it to obtain tokens and embeddings. 

The Management service should be exposed internally for agents only. 

Here's an example of running the balancer this way (assuming that `192.168.1.0` and `10.0.0.0` are two different subnets with no routing between them):

```bash
paddler balancer --inference-addr 192.168.1.10:8061 --management-addr 10.0.0.10:8060 
```

## Running agents

Agents need to be able to reach the Management service, so we will put them and the Management service in one isolated subnet with no external traffic at the routing level.

The optimal way is to run each agent on a separate device and give it several slots it can work with to handle the concurrent requests. And this is exactly what we will do in our multi-device setup.

Let's run agent-1 on one separate device:

```bash
paddler agent --management-addr 10.0.0.10:8060 --slots 4 --name agent-1
```

And the second agent-2 on another device:

```bash
paddler agent --management-addr 10.0.0.10:8060 --slots 4 --name agent-2
```

Additionally, if you want the agents to use models from Hugging Face, make sure your agents have access to the internet (or at least to Hugging Face).
