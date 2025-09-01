+++
layout = "LayoutDocumentationPage"
title = "Get agents stream"

[[collection]]
after = "api/management-service/get-agents"
name = "api_pages"
parent = "api/management-service/index"
+++

Similarly to the `/api/v1/agents`, this endpoint gives you the list of all agents but in a form of a stream of [server sent events (SSE)](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events). 

It sends a new event every time something changes in an agent (for example, when the number of busy slots is changed or there is a new issue, etc.). 

## Endpoint

```
Method: GET
Path: /api/v1/agents/stream
```

## Response

Each event is a JSON object, like this one:

```JSON
{
  "agents": [
    {
      "desired_slots_total": 4,
      "download_current": 0,
      "download_filename": null,
      "download_total": 0,
      "id": "123456",
      "issues": [],
      "model_path":"path/to/your/model.gguf",
      "name": "my-agent",
      "slots_processing": 0,
      "slots_total": 4,
      "state_application_status": "Applied",
      "uses_chat_template_override": false
    }
  ]
}
```
