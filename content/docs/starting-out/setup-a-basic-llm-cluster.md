+++
title = "Setup a basic LLM cluster"
weight = 1
+++

Before we dive into internals, let's set up a basic LLM cluster.

This will help you see how simple it is to get started with LLMs in a distributed environment with Paddler.

To get started, you do not need multiple devices; we can run everything on your local machine.

## Prerequisites
Make sure you have the Paddler binary on your local machine (see the [Installation](@/docs/introduction/installation.md) page for more details).

## Starting a basic cluster
To start a basic cluster, you only need two things: the Paddler's balancer and a single agent.

If you're curious about all of the possible options you can configure when starting the balancer, you can run the `paddler balancer --help` command to have them listed in your terminal. For now, however, we will keep things simple and start the balancer with its default configuration.

To start the balancer, run the following command in your terminal:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060
````

Starting the balancer this way starts two services that are minimally required to run Paddler's balancer:
- The inference service (used by applications that connect to it to obtain tokens or embeddings)
- The management service (which controls the whole Paddler setup). Take note of the management service's address and port - we will need them later when starting the agent.

To complete the basic cluster setup, we need to start an agent that will connect to the balancer. Running `paddler agent --help` will show you all the available options for the agent. There aren't many of them, and only two are needed when you start the agent: the management service's address and port, and the number of slots. 

When starting the balancer, we set the management service port to 8060, so this is what we'll use to tell the agent where to connect. The number of slots is the number of concurrent requests we want the agent to handle. Let's start with 2. With that, we can start the agent with the following command:

```bash
paddler agent --management-addr 127.0.0.1:8060 --slots 2
```

You can also name your agent. The name is optional and it's not used anywhere by Paddler's algorithms, but it's a convenient way to identify the agent when using Paddler's API or the web admin panel. You can set it with the `--name` option when running the agent, like this:

```bash
paddler agent --management-addr 127.0.0.1:8060 --slots 2 --name my-agent
```

Now you have a basic LLM cluster running on your local machine!

## Viewing your cluster
Paddler's clusters can be managed via API or a web admin panel. The web admin panel is a convenient way to see the status of your agents, set up the models, and more. You can enable the web admin panel by starting the balancer with the `--web-admin-panel-addr` flag followed by the address and port where you want to access it. In our case, let's start the panel on port 8062:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --web-admin-panel-addr 127.0.0.1:8062
```

Now, you can view your basic cluster in your web browser by navigating to `127.0.0.1:8062`!
