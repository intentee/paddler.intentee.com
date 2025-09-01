+++
layout = "LayoutDocumentationPage"
title = "Model swapping"

[[collection]]
after = "docs/starting-out/reporting-metrics"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Paddler allows you to dynamically swap models. You can do that either in the web admin panel or through the API.

## Video version

<iframe 
    height="315" 
    src="https://www.youtube-nocookie.com/embed/sWjTEaOg7Ig?si=9tr9I7bbTiusJf14" 
    title="YouTube video player" 
    frameborder="0" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
    referrerpolicy="strict-origin-when-cross-origin" 
    allowfullscreen
></iframe>

## Swapping models in the web admin panel

To swap models in the web admin panel, go to the "Model" section and use the "Model URI" field. You can either provide the link to the model's file on Hugging Face or a local file path to the model, for example:

<Figure 
    alt="Swapping models in the web admin panel"
    src="resources/images/model-swapping/swapping-model-web-admin-panel.avif"
/>

Next, click "Apply changes" to save the new model. The agents will automatically start using it.

## Swapping models through the API

To swap the model through the API, you should send the [request to change the balancer's desired state](api/management-service/put-balancer-desired-state) and provide the filename, repo ID, and the revision of the model. An example payload can look like this:

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
