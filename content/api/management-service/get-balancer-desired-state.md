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
    "context_size": 8192,
    "embedding_batch_size": 256,
    "enable_embeddings": false,
    "image_resize_to_fit": 1024,
    "k_cache_dtype": "Q8_0",
    "min_p": 0.05,
    "n_batch": 2048,
    "n_gpu_layers": 0,
    "penalty_frequency": 0.0,
    "penalty_last_n": -1,
    "penalty_presence": 0.8,
    "penalty_repeat": 1.1,
    "pooling_type": "Last",
    "temperature": 0.8,
    "top_k": 80,
    "top_p": 0.8,
    "v_cache_dtype": "Q8_0"    
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
