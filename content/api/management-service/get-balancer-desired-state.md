+++
title = "Get balancer desired state"
weight = 3
+++

This endpoint gives you the desired state you want the balancer to be in. It includes data such as inference parameters, selected model, or whether you want to override the chat template with your own.

The desired state is not necessarily the state applied to the balancer and agents. You can use the [get agents](@/api/management-service/get-agents.md) endpoint to monitor the model currently used by the agents.

## Endpoint

```
Method: GET
Path: /api/v1/balancer_desired_state
```

## Response

Example response if you're using a model from Hugging Face:

```JSON
{
  "chat_template_override": null,
  "inference_parameters": {
    "batch_n_tokens": 512,
    "context_size": 4096,
    "enable_embeddings": false,
    "min_p": 0.05,
    "penalty_frequency": 0,
    "penalty_last_n": -1,
    "penalty_presence": 1.5,
    "penalty_repeat": 1,
    "pooling_type": "Last",
    "temperature": 0.6,
    "top_k": 40,
    "top_p": 0.8
  },
  "model": {
    "HuggingFace": {
      "filename": "Qwen3-0.6B-Q8_0.gguf",
      "repo_id": "Qwen/Qwen3-0.6B-GGUF",
      "revision": "main"
    }
  },
  "use_chat_template_override": false
}
```
