+++
description = "GET /api/v1/balancer_applicable_state - Get the resolved state the balancer instructs the agents to apply."
layout = "LayoutDocumentationPage"
title = "Get balancer applicable state"

[[collection]]
after = "api/management-service/get-agents-stream"
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint returns the balancer's **applicable state**, the [desired state](api/management-service/get-balancer-desired-state) after it has been resolved into exactly what the balancer instructs the agents to apply.

It differs from the desired state in one way: the desired state carries a separate `use_chat_template_override` flag alongside `chat_template_override`. 

The applicable state resolves that flag: if `use_chat_template_override` was `true`, the applicable `chat_template_override` holds your template; if it was `false`, it is `null` and the agents use the model's built-in template. The `use_chat_template_override` field itself is therefore not present here. All other fields (`inference_parameters`, `model`, `multimodal_projection`) are unchanged.

## Endpoint

```
Method: GET
Path: /api/v1/balancer_applicable_state
```

## Response

If no state has been set yet, the response is `null`. Otherwise it returns the applicable state:

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
  "multimodal_projection": "None"
}
```
