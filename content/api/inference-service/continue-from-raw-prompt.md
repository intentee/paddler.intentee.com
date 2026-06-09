+++
description = "POST /api/v1/continue_from_raw_prompt - Generate token stream by sending raw prompts without applying any chat templates. Failsafe endpoint for edge cases."
layout = "LayoutDocumentationPage"
title = "Continue from raw prompt"

[[collection]]
after = "api/inference-service/continue-from-conversation-history"
name = "api_pages"
parent = "api/inference-service/index"
+++

<Note>
    This endpoint is here only as a fail-safe, workaround, just-in-case solution to handle some edge-cases we possibly didn't consider in Paddler.
</Note>

This endpoint allows you to send a raw prompt to the LLM without applying any chat templates and receive tokens in response.

Not applying the chat template means that whatever you pass as the raw prompt, Paddler will send directly to the LLM.

Generally, use the other endpoint to generate completions ([Continue from conversation history](api/inference-service/continue-from-conversation-history)), because they are much safer, and guarantee any kind of quality of the response. 

If you need to force your own chat template, prefer to do that through the [Balancer desired state endpoint](api/management-service/put-balancer-desired-state) instead.

## Endpoint

```
Method: POST
Path: /api/v1/continue_from_raw_prompt
```

## Payload

```JSON
{
    "max_tokens": 400,
    "raw_prompt": "How can I make my cat happy?"
}
```

### Parameters

#### `grammar`

Optional grammar that constrains the response. Accepts a `gbnf` or `json_schema` constraint. See [Using grammars](docs/starting-out/using-grammars) for details on both formats and the error cases.

#### `max_tokens`

Maximum number of tokens to generate in the response. This is a hard limit; use it as a failsafe to prevent the model from generating too many tokens.

#### `raw_prompt`

String with the raw prompt to send to the LLM.

## Response

### Success

The response body is a stream of JSON objects, one per generated token. Each token's inner key under `GeneratedToken` is the token kind. See [Continue from conversation history](api/inference-service/continue-from-conversation-history) for the full set of token kinds.

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

## Sending requests with a grammar

To constrain the response, pass a grammar in the optional `grammar` parameter:

```json
{
    "max_tokens": 20,
    "raw_prompt": "When did the Apollo 11 mission land on the Moon? Answer with the date only.",
    "grammar": {
        "type": "gbnf",
        "grammar": "root ::= [0-9] [0-9] [0-9] [0-9] \"-\" [0-9] [0-9] \"-\" [0-9] [0-9]",
        "root": "root"
    }
}
```

See [Using grammars](docs/starting-out/using-grammars) for both supported formats and the error cases.
