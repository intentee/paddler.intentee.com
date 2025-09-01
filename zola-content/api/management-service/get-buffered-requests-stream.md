+++
title = "Get buffered requests stream"
weight = 5
+++

Similarly to the `/api/v1/buffered_requests`, this endpoint gives you the list of the requests currently being buffered but in a form of a stream of [server sent events (SSE)](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events). 

Every time the number of buffered requests changes, a new event is sent.

## Endpoint

```
Method: GET
Path: /api/v1/buffered_requests/stream
```

## Response

Each event is a JSON object with the number of requests currently being buffered, for example:

```JSON
{
  "buffered_requests_current": 10
}
```
