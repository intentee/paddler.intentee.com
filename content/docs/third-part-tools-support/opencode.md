+++
description = "Learn how to use OpenCode with a Paddler cluster"
layout = "LayoutDocumentationPage"
title = "OpenCode"

[[collection]]
name = "documentation_pages"
parent = "docs/third-part-tools-support/index"
+++

OpenCode works with any OpenAI-compatible API, so it can use your Paddler cluster as its model provider.

## Start the balancer with the OpenAI-compatible service

OpenCode connects through Paddler's [OpenAI compatibility](docs/migrating-to-paddler/openai-compatibility) service. It is not enabled by default, so make sure to start the balancer with the `--compat-openai-addr` parameter:

```bash
paddler balancer \
    --compat-openai-addr 127.0.0.1:8070 \
    --inference-addr 127.0.0.1:8061 \
    --management-addr 127.0.0.1:8060
```

## Load a model that supports tool calling

[Load a model](docs/starting-out/loading-models-and-models-cache) that supports [function calling](docs/starting-out/using-function-calling). OpenCode edits files through tool calls, so without it, you'd only get descriptions of the changes.

## Configure OpenCode

Paddler is not one of OpenCode's built-in providers, so you need to add it as a custom one. Below is an example of an OpenCode config; you can put it in `opencode.json` in your project root, or in `~/.config/opencode/opencode.json` if you want it available everywhere:

```JSON
{
  "$schema": "https://opencode.ai/config.json",
  "model": "paddler/local",
  "provider": {
    "paddler": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Paddler",
      "options": {
        "baseURL": "http://127.0.0.1:8070/v1"
      },
      "models": {
        "local": {
          "name": "Qwen 3.6"
        }
      }
    }
  }
}
```

A few things about this configuration:

- `baseURL` is the address you passed to `--compat-openai-addr`, with `/v1` at the end.
- The model id is only a label. Paddler ignores the model name in a request and routes it to whatever model your cluster currently has loaded, so it does not need to change when you [swap models](docs/starting-out/model-swapping).
- The `models` field is required. Paddler does not expose an endpoint that lists models, so you have to declare them here.


## Run OpenCode

Finally, run `opencode` in your project. Paddler will show up as a provider, with the models you declared in the configuration, for example:

<Figure 
    alt="OpenCode running with Paddler as the model provider"
    src="resources/media/opencode/opencode-paddler-provider.avif"
/>
