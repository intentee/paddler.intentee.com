+++
title = "Continue from conversation history"
weight = 1
+++

This endpoint allows you to continue a conversation from a given history of messages. 

It takes your entire conversation history, uses the chat template to format the prompt, and generates tokens in response.

## Endpoint

```
Method: POST
Path: /api/v1/continue_from_conversation_history
```

## Payload

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

### Parameters

#### `add_generation_prompt`

Whether to append the opened `assistant` prompt to the conversation history.


#### `conversation_history` 

Array of all the previous conversation messages.

#### `enable_thinking`

If you are using a model that supports thinking (like DeepSeek, or Qwen), this will enable the thinking mode.

If you enable this mode you need to send the `thinking` part of the messages in the `conversation_history` array (the part between `<think>` and `</think>`) alongside the rest of the messages.

#### `max_tokens`

Maximum number of tokens to generate in the response. This is a hard limit, use it as a failsafe to prevent the model from generating too many tokens.

## Response

### Success

Stream of tokens in the reponse body. Each token is a JSON object:

```JSON
{
    "Response": {
        "request_id": "123456",
        "response": {
            "GeneratedToken": {
                "generated_token_result": {
                    "Token": "Hello"
                },
                "slot": 0
            }
        }
    }
}
```

The last token that ends the stream is:

```JSON
{
    "Response": {
        "request_id": "123456",
        "response": {
            "GeneratedToken": {
                "generated_token_result": "Done",
                "slot": 0
            }
        }
    }
}
```

### Error

In case of an error, the response will be:

```JSON
{
    "Error": {
        "request_id": "123456",
        "error": {
            "code": 123,
            "description": "Meaningful error message"
        }
    }
}
```
