+++
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

#### `max_tokens`

Maximum number of tokens to generate in the response. This is a hard limit; use it as a failsafe to prevent the model from generating too many tokens.

#### `raw_prompt`

String with the raw prompt to send to the LLM.

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
