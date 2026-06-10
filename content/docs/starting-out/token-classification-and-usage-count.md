+++
description = "Learn how Paddler classifies the tokens it generates by kind and counts them, then reports this per-kind token usage in its API responses."
layout = "LayoutDocumentationPage"
title = "Token classification and usage count"

[[collection]]
after = "docs/starting-out/model-swapping"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

As Paddler generates a response, it classifies every token it produces by kind and counts how many of each kind it processed, along with the size of the prompt. This per-kind token usage is reported back to you in the API responses, so you can see exactly how many tokens a request consumed and what they were spent on.

## Token kinds

Paddler classifies each generated token into one of four kinds:

- **content**: the model's actual answer.
- **reasoning**: the model's internal thinking (the content of a thinking model's reasoning block).
- **tool call**: the tokens that make up a tool (function) call.
- **undeterminable**: tokens that could not be classified into any of the kinds above.

## Where to find token usage

Token usage arrives at the very end of a generation stream, in the terminal `Done` event, inside its `usage` field:

```JSON
"usage": {
  "prompt_tokens": 318,
  "cached_prompt_tokens": 0,
  "input_image_tokens": 0,
  "input_audio_tokens": 0,
  "content_tokens": 2,
  "reasoning_tokens": 45,
  "tool_call_tokens": 40,
  "undeterminable_tokens": 0
}
```

The four counts named after the kinds, `content_tokens`, `reasoning_tokens`, `tool_call_tokens`, and `undeterminable_tokens`, tell you how many generated tokens fell into each kind. `prompt_tokens` is the size of your input, so it stands apart from the kinds. And for a request with an image, `input_image_tokens` holds the number of tokens that image occupied in the prompt. Note it is tracked separately from `prompt_tokens`.

Of the remaining fields, two are currently always zero and reserved for future use: `cached_prompt_tokens` and `input_audio_tokens`.

You will find the full response, including this `Done` event, documented with each endpoint, for example [Continue from conversation history](api/inference-service/continue-from-conversation-history). The OpenAI-compatible endpoints report the same counts under OpenAI's own field names (see [OpenAI compatibility](docs/migrating-to-paddler/openai-compatibility)).
