+++
description = "PUT /api/v1/balancer_desired_state - Apply the desired state you want the balancer to be in."
layout = "LayoutDocumentationPage"
title = "Put balancer desired state"

[[collection]]
after = "api/management-service/get-model-metadata"
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint allows you to apply the desired state of the balancer, including data such as inference parameters, selected model, or whether you want to override the chat template with your own.

## Endpoint

```
Method: PUT
Path: /api/v1/balancer_desired_state
```

## Payload

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
      "filename": "Qwen3-0.6B-Q8_0.gguf",
      "repo_id": "Qwen/Qwen3-0.6B-GGUF",
      "revision": "main"
    }
  },
  "multimodal_projection": "None",
  "use_chat_template_override": false
}
```

### Model sources

The `model` (and `multimodal_projection`) field selects where the model comes from. The example above uses Hugging Face; the other accepted forms are:

```json
"model": { "Url": { "url": "https://example.com/models/my-model.gguf" } }
```

```json
"model": { "LocalToAgent": "/path/to/your/model.gguf" }
```

```json
"model": "None"
```

A `Url` model is downloaded over `http(s)` — a direct link to the `.gguf` file that the agent can reach (including a server on your local network); a `LocalToAgent` path is read from the agent's own filesystem; `"None"` leaves no model loaded.

## Response

Responds with `204 No Content` if the request was successful.
