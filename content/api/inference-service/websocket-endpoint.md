+++
layout = "LayoutDocumentationPage"
title = "WebSocket endpoint"

[[collection]]
after = "api/inference-service/generate-embedding-batch"
name = "api_pages"
parent = "api/inference-service/index"
+++

Generally, conversational applications require a lot of back-and-forth communication between the client and the server.
WebSocket allows for a persistent connection, which reduces the overhead of establishing a new connection for each
request.

Paddler's inference endpoint multiplexes and demultiplexes multiple requests over a single connection, so you can
reuse the same socket for multiple requests at the same time.

## Endpoint

```
Method: WebSocket
Path: /api/v1/inference_socket
```

## Protocol

Paddler's protocol is similar to [JSON-RPC](https://www.jsonrpc.org/) in a sense that if follows the general
idea of giving each request a unique ID and returning a response with the same ID.

The primary difference is, to simplify the protocol, Paddler requires the same arguments as with the HTTP API, just
wrapped in an additional envelope with the ID of the request. For example:

```JSON
{
    "Request": {
        "id":"123456",
        "request": {
            "<MethodName>": {
                // parameters
            }
        }
    }
}
```

The response envelope looks like this:

```JSON
{
    "Response": {
        "request_id": "123456",
        "response": {
            // response data
        }
    }
}
```

## Supported methods

### Continue from conversation history

This method works exactly the same as its [HTTP counterpart](api/inference-service/continue-from-conversation-history).
You only need to wrap the request in the envelope and pass it to the WebSocket endpoint.

```JSON
{
    "Request": {
        "id": "123456",
        "request": {
            "ContinueFromConversationHistory": {
                "add_generation_prompt": true,
                "enable_thinking": true,
                "max_tokens": 400,
                "conversation_history": [
                    // ...
                ],
            }
        }
    }
}
```

After that you will receive a stream of responses, each containing a generated token. You can follow the HTTP docs for
the response format.

### Continue from raw prompt

Same as above, but you can follow input/output specification of the 
[Continue from raw prompt](api/inference-service/continue-from-raw-prompt) instead:

```JSON
{
    "Request": {
        "id": "123456",
        "request": {
            "ContinueFromRawPrompt": {
                "add_generation_prompt": true,
                "enable_thinking": true,
                "max_tokens": 400,
                "raw_prompt": "Hello, how are you?",
            }
        }
    }
}
```

You can know that the request is done when you receive the `"Done"` token in the response stream:

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
