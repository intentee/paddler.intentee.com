+++
description = "GET /api/v1/balancer_desired_state - Get the desired state you want the balancer to be in."
layout = "LayoutDocumentationPage"
title = "Get balancer desired state"

[[collection]]
after = "api/management-service/get-agents-stream"
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint gives you the desired state you want the balancer to be in. It includes data such as inference parameters, selected model, or whether you want to override the chat template with your own.

The desired state is not necessarily the state applied to the balancer and agents. You can use the [get agents](api/management-service/get-agents) endpoint to monitor the model currently used by the agents.

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
    "embedding_n_seq_max": 16,
    "enable_embeddings": false,
    "image_resize_to_fit": 1024,
    "min_p": 0.05,
    "penalty_frequency": 0.0,
    "penalty_last_n": -1,
    "penalty_presence": 1.5,
    "penalty_repeat": 1.0,
    "pooling_type": "Last",
    "temperature": 0.6,
    "top_k": 40,
    "top_p": 0.8
  },
  "model": {
    "HuggingFace": {
      "filename": "Qwen3.5-0.8B-Q4_K_M.gguf",
      "repo_id": "unsloth/Qwen3.5-0.8B-GGUF",
      "revision": "main"
    }
  },
  "multimodal_projection": {
    "HuggingFace": {
      "filename": "mmproj-F16.gguf",
      "repo_id": "unsloth/Qwen3.5-0.8B-GGUF",
      "revision": "main"
    }
  },
  "use_chat_template_override": false
}
```
