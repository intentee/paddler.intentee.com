+++
description = "GET /api/v1/buffered_requests - Get the number of requests currently being buffered."
layout = "LayoutDocumentationPage"
title = "Get buffered requests"

[[collection]]
after = "api/management-service/get-balancer-desired-state"
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint gives you the number of requests currently being buffered.

## Endpoint

```
Method: GET
Path: /api/v1/buffered_requests
```

## Response

```JSON
{
  "buffered_requests_current": 10
}
```
