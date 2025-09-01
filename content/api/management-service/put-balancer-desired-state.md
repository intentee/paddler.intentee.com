+++
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

## Response

Responds with `204 No Content` if the request was successful.
