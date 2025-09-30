+++
description = "GET /api/v1/agent/{agent_id}/chat_template_override - Get chat template override content."
layout = "LayoutDocumentationPage"
title = "Get chat template override"

[[collection]]
after = "api/management-service/get-buffered-requests-stream"
name = "api_pages"
parent = "api/management-service/index"
+++

If you provided your own chat template, you can use this endpoint to retrieve your chat template content.

## Endpoint

```
Method: GET
Path: /api/v1/agent/{agent_id}/chat_template_override
```

## Response

```JSON
{
  "content": "My custom chat template content"
}
```
