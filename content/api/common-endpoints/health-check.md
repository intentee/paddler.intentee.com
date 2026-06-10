+++
description = "GET /health - Get a health check that confirms if Paddler's services are running."
layout = "LayoutDocumentationPage"
title = "Health check"

[[collection]]
name = "api_pages"
parent = "api/common-endpoints/index"
+++

Paddler exposes a single `GET /health` liveness-check endpoint. It confirms that a service is running and responding, which is useful for load balancers, orchestrators, and uptime monitoring. The same endpoint is available on several of Paddler's services, so you can reach it at each of their addresses.

## Endpoint

```
Method: GET
Path: /health
```

It is exposed by the following services:

- the inference service (e.g. `http://127.0.0.1:8061/health`),
- the management service (e.g. `http://127.0.0.1:8060/health`),
- the OpenAI-compatible service, if you started it with `--compat-openai-addr` (e.g. `http://127.0.0.1:8070/health`).

## Response

Returns `200 OK` with the plain-text body `OK`.
