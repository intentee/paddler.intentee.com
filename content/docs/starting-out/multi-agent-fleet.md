+++
layout = "LayoutDocumentationPage"
title = "Multi-agent fleet"

[[collection]]
after = "docs/starting-out/using-function-calling"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Previously, we've started Paddler locally with a single agent. Let's now learn how to start multiple agents alongside the balancer, forming a fleet.

## Starting the balancer with the web admin panel enabled

Let's start by running the balancer with the web panel enabled, so that we can observe the newly added agents in the panel. Exactly as we did before, we will run the following command in the terminal, specifying the inference address and management services addresses and ports, as well as the address and port where we want to access the web admin panel from:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --web-admin-panel-addr 127.0.0.1:8062
```

## Starting the first agent

Since no agents are registered yet, the dashboard is empty, and you can see the "No agents registered yet" information at the bottom. 
Let's start our first agent in a new terminal window.
To run an agent, we need it to be able to reach the management service in the balancer (by providing the management service address and port; in our example, it is `127.0.0.1:8060`), and we need to define the number of slots. Naming an agent is optional, but useful when we want to distinguish different agents in the web admin panel or API. We'll name our first agent simply "agent-1", and start it with 4 slots:

```bash
paddler agent --management-addr 127.0.0.1:8060 --slots 4 --name agent-1
```

Once you run the command above, the dashboard will update instantly, showing the newly registered agent.

## Creating a multi-agent fleet

<Note>
    In our example, we are starting all agents on the same device, which will work just fine. The ideal setup, though, is to have each agent running on its own separate server and to give it slots to handle requests in parallel.
</Note>

Let's add two more agents to the fleet, repeating the step from above, but of course, we will use different names for each new agent.

In a new terminal window, run:

```bash
paddler agent --management-addr 127.0.0.1:8060 --slots 4 --name agent-2
```

You'll notice the dashboard will update automatically again. 

Open another window, and run:

```bash
paddler agent --management-addr 127.0.0.1:8060 --slots 4 --name agent-3
```

We now have a fleet of three agents, each distinguishable by its custom name, connected to the balancer in the management service via a WebSocket connection. The balancer will distribute the incoming requests evenly between the agents. 

## Testing the request distribution

Paddler's web admin panel comes with a GUI that lets you test your Paddler setup. To use it, we first need to load a model and specify the chat template. We can do that via Paddler's web admin panel, in the "Model" section.

For our example, let's use `Qwen3-0.6B-GGUF`, which is a convenient small model for testing, and it comes with a chat template. 

We'll load the model from Hugging Face by providing the model's link `https://huggingface.co/Qwen/Qwen3-0.6B-GGUF/blob/main/Qwen3-0.6B-Q8_0.gguf` into the input, select the "Use the chat template provided by the model" option, and submit the form. 

As soon as Paddler downloads the model, you'll notice the model's name on the dashboard.

That's all we need to start testing. Now, let's open the dashboard in one web browser tab, and the "Prompt" page in at least two other tabs. In each of the "Prompt" tabs, we'll enter a prompt and submit it. The balancer will distribute the requests evenly between the agents, and you can see which agent is processing each request on the dashboard.
