+++
description = "GET /api/v1/agent/{agent_id}/model_metadata - Get the metadata of the model currently used by the agent."
layout = "LayoutDocumentationPage"
title = "Get model metadata"

[[collection]]
after = "api/management-service/get-chat-template-override"
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint gives you the metadata of the model currently used by the agent.

## Endpoint

```
Method: GET
Path: /api/v1/agent/{agent_id}/model_metadata
```

## Response

An example response. The `tokenizer.chat_template` field holds the model's full chat template, which is very long, so it is truncated below:

```JSON
{
  "metadata": {
    "general.architecture": "qwen35",
    "general.base_model.0.name": "Qwen3.5 0.8B",
    "general.base_model.0.organization": "Qwen",
    "general.base_model.0.repo_url": "https://huggingface.co/Qwen/Qwen3.5-0.8B",
    "general.base_model.count": "1",
    "general.basename": "Qwen3.5-0.8B",
    "general.file_type": "15",
    "general.license": "apache-2.0",
    "general.license.link": "https://huggingface.co/Qwen/Qwen3.5-0.8B/blob/main/LICENSE",
    "general.name": "Qwen3.5-0.8B",
    "general.quantization_version": "2",
    "general.quantized_by": "Unsloth",
    "general.repo_url": "https://huggingface.co/unsloth",
    "general.size_label": "0.8B",
    "general.type": "model",
    "quantize.imatrix.chunks_count": "80",
    "quantize.imatrix.dataset": "unsloth_calibration_Qwen3.5-0.8B.txt",
    "quantize.imatrix.entries_count": "186",
    "quantize.imatrix.file": "Qwen3.5-0.8B-GGUF/imatrix_unsloth.gguf",
    "qwen35.attention.head_count": "8",
    "qwen35.attention.head_count_kv": "2",
    "qwen35.attention.key_length": "256",
    "qwen35.attention.layer_norm_rms_epsilon": "0.000001",
    "qwen35.attention.value_length": "256",
    "qwen35.block_count": "24",
    "qwen35.context_length": "262144",
    "qwen35.embedding_length": "1024",
    "qwen35.feed_forward_length": "3584",
    "qwen35.full_attention_interval": "4",
    "qwen35.rope.dimension_count": "64",
    "qwen35.rope.freq_base": "10000000.000000",
    "qwen35.ssm.conv_kernel": "4",
    "qwen35.ssm.group_count": "16",
    "qwen35.ssm.inner_size": "2048",
    "qwen35.ssm.state_size": "128",
    "qwen35.ssm.time_step_rank": "16",
     "tokenizer.chat_template": "{%- set image_count = namespace(value=0) %}\n{%- set video_count = namespace(value=0) %}\n... (truncated for brevity)",
    "tokenizer.ggml.eos_token_id": "248046",
    "tokenizer.ggml.model": "gpt2",
    "tokenizer.ggml.padding_token_id": "248055",
    "tokenizer.ggml.pre": "qwen35"
  }
}
```
