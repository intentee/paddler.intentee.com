+++
title = "Model swapping"
weight = 10
+++

Paddler allows you to dynamically swap models. You can do that either in the web admin panel or through the API.

## Swapping models in the web admin panel

To swap models in the web admin panel, go to the "Model" section and use the "Model URI" field. You can either provide the link to the model's file on Hugging Face or a local file path to the model, for example:

{{ figure_image(path="swapping-model-web-admin-panel.avif", alt="Swapping models in the web admin panel") }}

Next, click "Apply changes" to save the new model. The agents will automatically start using it.

## Swapping models through the API

To swap the model through the API, you should send the [request to change the balancer's desired state](@/api/management-service/put-balancer-desired-state.md) and provide the filename, repo ID, and the revision of the model. An example payload can look like this:

```json
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

Similarly to swapping models through the web admin panel, sending this request with the new model will make the agents use it automatically.
