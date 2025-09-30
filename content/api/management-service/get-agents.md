+++
description = "GET /api/v1/agents - Get the list of all currently registered agents."
layout = "LayoutDocumentationPage"
title = "Get agents"

[[collection]]
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint gives you a list of all agents you have currently registered in Paddler.

## Endpoint

```
Method: GET
Path: /api/v1/agents
```

## Response

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
      "model_path": "path/to/your/model.gguf",
      "name": "my-agent",
      "slots_processing": 0,
      "slots_total": 4,
      "state_application_status": "Applied",
      "uses_chat_template_override": false
    }
  ]
}
```

### Issues

If there are any issues with the agent, they will be listed in the `issues` array. For example, here's a response for an agent with an incorrect model path:

```JSON
{
  "agents": [
      {
        "desired_slots_total": 4,
        "download_current": 0,
        "download_filename": null,
        "download_total": 0,
        "id": "123456",
        "issues": [
          {
            "HuggingFaceModelDoesNotExist": "Qwen/Qwen3-0.6B-GGUF/incorrect-link/.gguf"
          }
        ],
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
