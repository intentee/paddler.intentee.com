+++
title = "Generating tokens and embeddings"
weight = 3
+++

Paddler exposes both REST and WebSocket API you can use to generate tokens and embeddings. You will find detailed documentation for each endpoint in the [API docs](@/api/introduction/using-paddler-api.md).   

Let's test a few endpoints.

## Generating tokens using the "Continue from conversation history" endpoint.

This is the primary endpoint to receive tokens. It takes your entire conversation history, uses the chat template to format a prompt, and sends you back the generated tokens. It's documented [here](@/api/inference-service/continue-from-conversation-history.md). 

An example payload may look like this:

```JSON
{
    "add_generation_prompt": true,
    "enable_thinking": true,
    "max_tokens": 400,
    "conversation_history": [
        {
            "role": "system",
            "content": "You are a helpful assistant."
        },
        {
            "role": "user",
            "content": "Hello, how are you?"
        },
        {
            "role": "assistant",
            "content": "I'm fine, thank you! How can I assist you today?"
        }
    ]
}
```

Let's take this payload and test it with [Bruno](https://www.usebruno.com/), a convenient tool to test http requests:

{{ figure_image(path="testing-post-continue-from-conversation-history.avif", alt="Testing the request to generate tokens") }}

The response presented in Bruno (right side in the screenshot above) shows how tokens in the response are returned as a stream.

## Generating embeddings using "Generate embedding batch"

Paddler also comes with an endpoint to generate embeddings, documented [here](@/api/inference-service/generate-embedding-batch.md). 

To test it, we need first to ensure we have embeddings enabled (see: [How to enable embeddings](@/docs/internals/how-to-enable-embeddings/index.md) for more information).

Our example payload can be something like this:

```JSON
{
  "input_batch": [
    {
      "id": "1",
      "content": "This is how we should keep our company cats happy"
    }
  ],
  "normalization_method": "L2"
}
```

Same as before, we will test it with Bruno. This time, we get a stream of embeddings:

{{ figure_image(path="testing-post-generate-embedding-batch.avif", alt="Testing the request to generate embeddings") }}

## Customizing the maximum time for generating a single token or embedding

You can change the maximum time of generating a single token or embedding before the generation process times out. 

By default, this time is set to 5000 milliseconds. This value can be customized when running the balancer with the `--inference-item-timeout` flag (the value should be provided in milliseconds).
