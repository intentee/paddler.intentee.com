+++
description = "Swap models dynamically using API or the web admin panel without the need to restart the balancer or the agents."
layout = "LayoutDocumentationPage"
title = "Model swapping"

[[collection]]
after = "docs/starting-out/reporting-metrics"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Paddler allows you to dynamically swap models. You can do that either in the web admin panel or through the API.

## Swapping models in the web admin panel

To swap models in the web admin panel, go to the "Model" section and use the "Base Model URI" field (and, optionally, also the "Multimodal Projection URI" if you're using the multimodal functionality). You can either provide the link to the model's file on Hugging Face or a local file path to the model, for example:

<Figure 
    alt="Swapping models in the web admin panel"
    src="resources/media/model-swapping/swapping-model-web-admin-panel.avif"
/>

Next, click "Apply changes" to save the new model. The agents will automatically start using it.

## Swapping models through the API

To swap the model through the API, you should send the [request to change the balancer's desired state](api/management-service/put-balancer-desired-state) and provide the filename, repo ID, and the revision of the model. An example payload can look like this:

```json
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

Similarly to swapping models through the web admin panel, sending this request with the new model will make the agents use it automatically.
