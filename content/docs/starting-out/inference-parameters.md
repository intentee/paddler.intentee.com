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

<table>
    <thead>
        <tr>
            <th>Parameter</th>
            <th>Default value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                `batch_n_tokens`
            </td>
            <td>
                512
            </td>
        </tr>
        <tr>
            <td>
                `context_size`
            </td>
            <td>
                4096
            </td>
        </tr>
        <tr>
            <td>
                `min_p`
            </td>
            <td>
                0,05
            </td>
        </tr>
        <tr>
            <td>
                `penalty_frequency`
            </td>
            <td>
                0
            </td>
        </tr>        
        <tr>
            <td>
                `penalty_last_n`
            </td>
            <td>
                -1
            </td>
        </tr>
        <tr>
            <td>
                `penalty_presence`
            </td>
            <td>
                1,5
            </td>
        </tr>
        <tr>
            <td>
                `penalty_repeat`
            </td>
            <td>
                1
            </td>
        </tr>
        <tr>
            <td>
                `temperature`
            </td>
            <td>
                0,6
            </td>
        </tr>
        <tr>
            <td>
                `top_k`
            </td>
            <td>
                40
            </td>
        </tr>
        <tr>
            <td>
                `top_p`
            </td>
            <td>
                0,8
            </td>
        </tr>        
    </tbody>
</table>

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

Additionally, notice that the specific values are often provided by the models' authors. For example, the Qwen3-0.6B-GGUF model's card on Hugging Face includes a section with recommended inference parameters. When loading a new model, it is worth checking the model card for any such recommendations.

<Figure 
    alt="Model's parameter recommendations, source: Qwen3-0.6B-GGUF page on Hugging Face"
    src="resources/media/how-to-control-response-quality/qwen-3-06b-parameters-recommendations.avif"
/>
