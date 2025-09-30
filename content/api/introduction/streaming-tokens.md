+++
description = "An introduction to Paddler's endpoints that return tokens in a streaming fashion with code examples."
layout = "LayoutDocumentationPage"
title = "Streaming tokens"

[[collection]]
after = "api/introduction/using-paddler-api"
name = "api_pages"
parent = "api/introduction/index"
+++

Endpoints like [Continue from conversation history](api/inference-service/continue-from-conversation-history) or [Continue from raw prompt](api/inference-service/continue-from-raw-prompt) return tokens in a streaming fashion.

They use POST requests that return chunked stream of serialized JSON object (you should *not* confuse it with [Server-Sent Events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events)).

## Example usage

This example shows how to use them through JavaScript's `fetch` API, but the general pattern applies to most of the languages and libraries:

```js
const response = await fetch('http://127.0.0.1:8061/api/v1/continue_from_raw_prompt', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify({
        max_tokens: 100,
        raw_prompt: "Tell me a story about"
    })
});

const reader = response.body.getReader();
const decoder = new TextDecoder();

while (true) {
    const { done, value } = await reader.read();
    
    if (done) {
        break;
    }
    
    const chunk = decoder.decode(value, { stream: true });
    const lines = chunk.split('\n').filter(line => line.trim());
    
    for (const line of lines) {
        try {
            const message = JSON.parse(line);

            console.log('Received:', message.Response.response.GeneratedToken.Token);
        } catch (err) {
            console.error('Error:', err);
        }
    }
}
```
