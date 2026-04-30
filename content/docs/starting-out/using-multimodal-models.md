+++
description = "Send images alongside text to vision-language models. Configure multimodal projection files, learn about supported image formats, and image resizing."
layout = "LayoutDocumentationPage"
title = "Using multimodal models"

[[collection]]
after = "docs/starting-out/using-grammars"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Paddler supports vision-language models, allowing you to include images alongside text in your conversations. This is useful for tasks like image description or reasoning about image content.

To use multimodal capabilities, you need a model that supports vision and its corresponding multimodal projection file.

<Note>
    Currently, Paddler supports images as the multimodal input. Audio and video are not yet supported.
</Note> 

## Setting up a multimodal model

### Using the web admin panel

In the "Model" section, you will see the "Multimodal Projection URI" field below the main (so-called "base") model URI field. Provide the projection file relevant to the base model in the same way as the base model: either as a link to Hugging Face or a local file path. 

<Figure 
    alt="Providing the Multimodal Projection URI in the Web Admin Panel"
    src="resources/media/using-multimodal-models/mmproj-input.avif"
/>

Model authors usually name the projection files similarly to "mmproj-*.gguf" and place them under the base model files.

Click "Apply changes" to load the model. Once it is ready, the agents will start processing images.

<Note>
    The "Multimodal Projection URI" field is optional. If you don't want to use it, leave the field empty and only provide the base model.
</Note> 

### Using the API

To enable the multimodal functionality through the API, specify the desired mmproj file in the `multimodal_projection` field in the [PUT request to change the balancer's desired state](api/management-service/put-balancer-desired-state), for example:

### Payload

```JSON
{
  "chat_template_override": null,
  "inference_parameters": {
    "batch_n_tokens": 512,
    "context_size": 4096,
    "enable_embeddings": false,
    "image_resize_to_fit": 1024,
    "k_cache_dtype": "Q8_0",
    "min_p": 0.05,
    "n_gpu_layers": 0,
    "penalty_frequency": 0.0,
    "penalty_last_n": -1,
    "penalty_presence": 1.5,
    "penalty_repeat": 1.0,
    "pooling_type": "Last",
    "temperature": 0.6,
    "top_k": 40,
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

## Sending images in conversations

Images must be sent as base64-encoded data URIs. Paddler does not support fetching remote URLs, so images must be embedded directly in the requests.

### Using the web admin panel

In the "Prompt" section, you can upload images as attachments to the user prompts. Click the "image" icon in the message input to attach an image from your device. The image will be sent alongside your text message:

<Figure 
    alt="Adding images in the Prompt section of the Web Admin Panel"
    src="resources/media/using-multimodal-models/prompt-input-image-upload.avif"
/>

### Using the API

To send an image through the [Continue from conversation history](api/inference-service/continue-from-conversation-history) endpoint, pass the message content as an array of text and image entries: 

```JSON
{
  "add_generation_prompt": true,
  "enable_thinking": true,
  "max_tokens": 400,
  "conversation_history": [
    {
      "role": "user",
      "content": [
        {
          "type": "image_url",
          "image_url": {
            "url": "data:image/<format>;base64,<base64-encoded-image>"
          }
        },
        {
          "type": "text",
          "text": "Describe this image."
        }
      ]
    }
  ]
}
```

The `content` field accepts either a plain string for text-only messages or an array for messages with images. Each entry in the array is either a text or an image_url with a base64 data URI.

## Important considerations

### Supported image formats

Paddler supports the following image formats:

- JPEG
- PNG
- GIF
- BMP
- WebP
- SVG

### Image resizing

Models are typically trained on specific resolutions, and encoding large images can significantly slow down inference. For this reason, Paddler provides the `image_resize_to_fit` field to limit the maximum image dimension in pixels. Paddler scales down larger images internally before encoding them for the model, preserving the aspect ratio. Images smaller than this value are left unchanged. The default is 1024.

## Troubleshooting

- If you send images to a model that does not have a multimodal projection file loaded, the request will return a `MultimodalNotSupported` error. 
- If the image cannot be decoded (unsupported format, corrupted data), the request will return an `ImageDecodingFailed` error.
