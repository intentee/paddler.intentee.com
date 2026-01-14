+++
description = "Customize inference parameters to control how the model generates responses. Adjust temperature, penalties, and other parameters via the web admin panel or API."
layout = "LayoutDocumentationPage"
title = "Inference parameters"

[[collection]]
after = "docs/starting-out/generating-tokens-and-embeddings"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Paddler allows you to customize inference parameters that control how the model behaves during inference. You can adjust these parameters in the web admin panel or through the API.

## Available parameters

### `batch_n_tokens`

The number of tokens processed in parallel during prompt evaluation. Higher = more memory usage, lower = less inference speed. Adjust if you're running into memory limits or want to optimize throughput on capable hardware

### `context_size`

Maximum tokens in the context window. Higher = longer chat history, lower = less memory usage. Increase for longer conversations, decrease if you're memory-constrained.

### `min_p`

Minimum token probability to consider for selection. Increase if the model produces nonsensical tokens. Decrease if responses feel too constrained.

### `penalty_frequency`

Penalizes tokens proportionally to how often they appeared. Increase if the model repeats the same words too often.

### `penalty_last_n`

How many recent tokens to consider when applying repetition penalties. Use -1 for entire context, 0 to disable penalties entirely.

### `penalty_presence`

Penalizes tokens that appeared at all, regardless of frequency. Increase if you want the model to explore new topics instead of dwelling on what it already mentioned.

### `penalty_repeat`

Penalizes repeated tokens. Increase if the model repeats itself. Set to 1 to disable.

### `temperature`

Controls output randomness. Decrease for more predictable, focused responses. Increase for more creative, varied output.

### `top_k`

Limits selection to the K most likely tokens. Decrease for more predictable output. Increase to give the model more token choices.

### `top_p`

Limits selection to tokens whose cumulative probability reaches this threshold. Decrease for more focused responses. Increase to give the model more token choices.

## Setting parameters in the web admin panel

You can customize inference parameters in [the "Model" section of the web admin panel](docs/starting-out/using-web-admin-panel).
Below the chat template settings, you will see each parameter's name and an editable input next to it. Adjust them as needed and click "Apply changes" to save.

<Figure 
    alt="Customizing inference parameters in Paddler"
    src="resources/media/how-to-control-response-quality/paddler-model-inference-parameters-customization.avif"
/>

## Setting parameters through API

To set inference parameters through the API, adjust them in the [PUT request to change the balancer's desired state](api/management-service/put-balancer-desired-state). Here is an example payload:

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

## Finding the right values

The default parameters provide a reasonable starting point, but experimenting with different values is worth the effort. The optimal settings depend on your specific model and use case.


Additionally, notice that the models' authors often provide the specific values. For example, the Qwen3-0.6B-GGUF model's card on Hugging Face includes a section with recommended inference parameters. When loading a new model, it is worth checking the model card for any such recommendations.

<Figure 
    alt="Model's parameter recommendations, source: Qwen3-0.6B-GGUF page on Hugging Face"
    src="resources/media/how-to-control-response-quality/qwen-3-06b-parameters-recommendations.avif"
/>
