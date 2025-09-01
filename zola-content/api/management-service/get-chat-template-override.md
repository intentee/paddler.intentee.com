+++
title = "Get chat template override"
weight = 6
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
