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


#### `grammar`

Optional grammar that constrains the model output. When set, the model can only generate tokens that keep the output valid against the grammar. Two formats are supported: `gbnf` and `json_schema`. See [Using grammars](docs/starting-out/using-grammars) for details.

Cannot be used together with `enable_thinking: true`.


#### `max_tokens`

Maximum number of tokens to generate in the response. This is a hard limit; use it as a failsafe to prevent the model from generating too many tokens.

## Response

### Success

The response body is a stream of JSON objects, one per generated token. The inner key under `GeneratedToken` tells you what kind of token it is: `ContentToken` for the visible answer, `ReasoningToken` for thinking output (when `enable_thinking` is on), `ToolCallToken` for function-call output, or `UndeterminableToken` for generated text the classifier couldn't assign to one of those categories.

```JSON
{
    "Response": {
        "generated_by": "agent-1",
        "request_id": "123456",
        "response": {
            "GeneratedToken": {
                "ContentToken": "Hello"
            }
        }
    }
}
```

`generated_by` is the name of the agent that produced the token (its `--name`), or `null` if the agent has no name.

The stream ends with a single `Done` message that carries the token usage for the request:

```JSON
{
    "Response": {
        "generated_by": "agent-1",
        "request_id": "123456",
        "response": {
            "GeneratedToken": {
                "Done": {
                    "usage": {
                        "prompt_tokens": 12,
                        "cached_prompt_tokens": 0,
                        "input_image_tokens": 0,
                        "input_audio_tokens": 0,
                        "content_tokens": 34,
                        "reasoning_tokens": 0,
                        "tool_call_tokens": 0,
                        "undeterminable_tokens": 0
                    }
                }
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

## Sending requests with a grammar

To constrain the response, pass a grammar in the optional `grammar` parameter. Set `enable_thinking` to `false` as grammars and thinking mode cannot be used together.

### GBNF payload

```json
{
    "add_generation_prompt": true,
    "enable_thinking": false,
    "max_tokens": 20,
    "grammar": {
        "type": "gbnf",
        "grammar": "root ::= [0-9] [0-9] [0-9] [0-9] \"-\" [0-9] [0-9] \"-\" [0-9] [0-9]",
        "root": "root"
    },
    "conversation_history": [
        {
            "role": "user",
            "content": "When did the Apollo 11 mission land on the Moon? Answer with the date only."
        }
    ]
}
```

### JSON Schema payload

```json
{
    "add_generation_prompt": true,
    "enable_thinking": false,
    "max_tokens": 200,
    "grammar": {
        "type": "json_schema",
        "schema": "{\"type\":\"object\",\"properties\":{\"name\":{\"type\":\"string\"},\"age\":{\"type\":\"integer\"},\"occupation\":{\"type\":\"string\",\"enum\":[\"engineer\",\"teacher\",\"doctor\",\"artist\"]},\"employed\":{\"type\":\"boolean\"},\"hobbies\":{\"type\":\"array\",\"items\":{\"type\":\"string\"}}},\"required\":[\"name\",\"age\",\"occupation\",\"employed\",\"hobbies\"]}"
    },
    "conversation_history": [
        {
            "role": "user",
            "content": "Extract a structured record from: 'John is a 35-year-old engineer who is currently employed and enjoys hiking and chess.'"
        }
    ]
}
```

See [Using grammars](docs/starting-out/using-grammars) for the full description of both formats and the error cases.

## Sending requests with images

To include images, pass the message `content` as an array of text and image entries instead of a single string. Images must be base64-encoded data URIs.

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

For more details on setting up a vision-language model and supported image formats, see [Using multimodal models](docs/starting-out/using-multimodal-models)
