+++
description = "POST /api/v1/continue_from_conversation_history - Generate token stream from conversation history using chat template. Supports function calling and thinking mode."
layout = "LayoutDocumentationPage"
title = "Continue from conversation history"

[[collection]]
name = "api_pages"
parent = "api/inference-service/index"
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

If you enable this mode you need to send the `thinking` part of the messages in the `conversation_history` array (the part between `&lt;think&gt;` and `&lt;/think&gt;`) alongside the rest of the messages.

#### `max_tokens`

Maximum number of tokens to generate in the response. This is a hard limit; use it as a failsafe to prevent the model from generating too many tokens.

## Response

### Success

Stream of tokens in the response body. Each token is a JSON object:

```JSON
{
    "Response": {
        "request_id": "123456",
        "response": {
            "GeneratedToken": {
                "Token": "Hello"
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
            "GeneratedToken": "Done",
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

## Sending requests with function calling

To use function calling with this endpoint, you need to define the functions in the optional `tools` parameter.

An example payload with the function calling might look like this:

```json
{
    "add_generation_prompt": true,
    "enable_thinking": true,
    "max_tokens": 400,
    "tools": [
        {
            "type": "function",
            "function": {
                "name": "get_weather",
                "description": "Get the current weather information for a specified location.",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "location": {
                            "type": "string",
                            "description": "The city and state, e.g. San Francisco, CA"
                        },
                        "unit": {
                            "type": "string",
                            "enum": ["celsius", "fahrenheit"],
                            "description": "The temperature unit to use. Defaults to fahrenheit."
                        }
                    },
                    "required": ["location"]
                }
            }
        }
    ],
    "conversation_history": [
        {
            "role": "system",
            "content": "You are a helpful assistant that provides weather information"
        },
        {
            "role": "user",
            "content": "What's the weather like in New York City?"
        }
    ]
}
```

And the possible response:

```txt
<tool_call>
{
    "name": "get_weather",
    "arguments": {
        "location": "New York City, NY",
        "unit": "fahrenheit"
    }
}
</tool_call>
```
