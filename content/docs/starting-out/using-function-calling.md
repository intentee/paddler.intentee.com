+++
description = "Include functions in the optional tools parameter in your API requests to the Continue from conversation history endpoint and use function calling in your applications."
layout = "LayoutDocumentationPage"
title = "Using function calling"

[[collection]]
after = "docs/starting-out/inference-parameters"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

The [Continue from conversation history](api/inference-service/continue-from-conversation-history) endpoint allows you to use function calling in your applications.

To use function calling, add your functions in the optional `tools` parameter in your request. They are added to the prompt according to the model's chat template (usually to the system prompt) and processed by the model.

When the model makes a tool call, by default it is streamed back as raw text, and **the exact format depends on the model**: different models emit different shapes (for example, a `&lt;tool_call&gt;{...}&lt;/tool_call&lt;` block, or a `&lt;function=...&gt;` style). The format is decided by the model you load. For a single, consistent parsed result regardless of the model, set `parse_tool_calls` to `true` (see "Structured tool calls" below).

Paddler validates each parsed tool call's arguments against the JSON Schema you provide in the function's `parameters`.

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
    "name": "manage_zoo_animals", 
    "arguments": {
        "action": "create", 
        "animal": {
            "name": "Johnson", 
            "species": "kangaroo", 
            "age": 2
        }
    } 
}
</tool_call>
```

## Structured tool calls

By default, a tool call is streamed back as raw text in whatever format the model emits (as in the examples above). To get a single, consistent parsed result regardless of the model, set `parse_tool_calls` to `true` in your request (alongside `tools`).

With it enabled, Paddler parses the model's output and returns a `ToolCallParsed` result:

```json
{
    "Response": {
        "generated_by": "agent-1",
        "request_id": "123456",
        "response": {
            "GeneratedToken": {
                "ToolCallParsed": [
                    {
                        "id": "call_0",
                        "name": "get_weather",
                        "arguments": {
                            "ValidJson": {
                                "location": "New York City",
                                "unit": "fahrenheit"
                            }
                        }
                    }
                ]
            }
        }
    }
}
```

Each parsed call has an `id`, the function `name`, and `arguments`. `arguments` is tagged - `ValidJson` holds the parsed object when the model produced valid JSON, and `InvalidJson` holds the raw string when it did not.

### Troubleshooting

If parsing or validation does not succeed, you get one of these instead of `ToolCallParsed`:

- `ToolCallParseFailed`: the tool-call text could not be parsed.
- `ToolCallValidationFailed`: it parsed, but did not match the tool's parameter schema.
- `UnrecognizedToolCallFormat`: the output did not match a recognized tool-call format (includes the raw text).
- `ToolSchemaInvalid`: the `parameters` schema you supplied in `tools` is not a valid JSON Schema.
