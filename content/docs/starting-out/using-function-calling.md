+++
description = "Include functions in the optional tools parameter in your API requests to the Continue from conversation history endpoint and use function calling in your applications."
layout = "LayoutDocumentationPage"
title = "Using function calling"

[[collection]]
after = "docs/starting-out/generating-tokens-and-embeddings"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

The [Continue from conversation history](api/inference-service/continue-from-conversation-history) endpoint allows you to use function calling in your applications. 

Paddler uses the [Hermes format](https://github.com/NousResearch/Hermes-Function-Calling) for function calling and will validate your list of functions against the Hermes schema.

To use function calling, add your functions in the optional `tools` parameter in your request. It will then be added to the prompt according to the chat template used (usually to the system prompt) and processed by the model.

Let's take a look at a few examples of using function calling.

## Get weather example

### Payload

```json
{
    "add_generation_prompt": true,
    "enable_thinking": true,
    "max_tokens": 400,
    "tools": [
        {
            "type": "function",
            "function": {
                "name": "get_weather",
                "description": "Get the current weather information for a specified location.",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "location": {
                            "type": "string",
                            "description": "The city and state, e.g. San Francisco, CA"
                        },
                        "unit": {
                            "type": "string",
                            "enum": ["celsius", "fahrenheit"],
                            "description": "The temperature unit to use. Defaults to fahrenheit."
                        }
                    },
                    "required": ["location"]
                }
            }
        }
    ],
    "conversation_history": [
        {
            "role": "system",
            "content": "You are a helpful assistant that provides weather information"
        },
        {
            "role": "user",
            "content": "What's the weather like in New York City?"
        }
    ]
}
```

### Response

```txt
<tool_call>
{
    "name": "get_weather",
    "arguments": {
        "location": "New York City, NY",
        "unit": "fahrenheit"
    }
}
</tool_call>
```

## Manage zoo animals example

### Payload

```json
{
    "add_generation_prompt": true,
    "enable_thinking": true,
    "max_tokens": 4000,
    "tools": [
        {
            "type": "function",
            "function": {
                "name": "manage_zoo_animals",
                "description": "Create, read, update, or delete zoo animal records in the system.",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "action": {
                            "type": "string",
                            "enum": ["create", "read", "update", "delete"],
                            "description": "The action to perform on the zoo animal record."
                        },
                        "animal": {
                            "type": "object",
                            "description": "The zoo animal record to create, read, update, or delete.",
                            "properties": {
                                "name": { 
                                    "type": "string", 
                                    "description": "The name of the animal." 
                                },
                                "species": { 
                                    "type": "string", 
                                    "description": "The species of the animal." 
                                },
                                "age": { 
                                    "type": "integer", 
                                    "description": "The age of the animal in years." 
                                }
                            },
                            "required": ["name", "species", "age"],
                            "additionalProperties": { "type": "string" }
                        }
                    },
                    "required": ["animal"]
                }
            }
        }
    ],
    "conversation_history": [
        {
            "role": "system",
            "content": "You are a helpful assistant that manages zoo"
        },
        {
            "role": "user",
            "content": "I need to register a new kangaroo, he's 2 years old, his name is Johnson"
        }
    ]
}
```

### Response

```txt
<tool_call> 
{
    "name ": "manage_zoo_animals", 
    "arguments ": {
        "action ": "create", 
        "animal ": {
            "name ": "Johnson", 
            "species": "kangaroo", 
            "age": 2
        }
    } 
}
</tool_call>
```
