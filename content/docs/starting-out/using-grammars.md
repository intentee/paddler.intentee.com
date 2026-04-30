+++
description = "Constrain model output with GBNF grammars or JSON Schema. Force the model to produce only valid JSONs and other structured formats you can describe."
layout = "LayoutDocumentationPage"
title = "Using grammars"

[[collection]]
after = "docs/starting-out/using-function-calling"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Paddler lets you constrain model output with a grammar. When a request includes a grammar, the model can only generate tokens that keep the output valid against it (invalid tokens are masked out at each decoding step). This is useful when you need structured output, like JSON matching a specific schema, a fixed set of allowed values, or your own custom format, instead of relying on prompting alone to get it right.   

Two grammar formats are supported: **GBNF** and **JSON Schema** (which Paddler converts to GBNF for you).

You can attach a grammar to requests sent to the [Continue from conversation history](api/inference-service/continue-from-conversation-history) and [Continue from raw prompt](api/inference-service/continue-from-raw-prompt) endpoints. The OpenAI compatibility endpoint does not currently support grammars.

<Note>
    Grammars are incompatible with the thinking mode. If you send a request with both `enable_thinking: true` and a grammar, it will fail with a `GrammarIncompatibleWithThinking` error. 
    
    Set `enable_thinking` to `false` when using grammars.
</Note>

## Constraining output to a custom format (GBNF)

Use `gbnf` when you want full control over the output format. Provide the grammar rules as a string and tell Paddler which rule to start from.

### Payload

```json
{
    "add_generation_prompt": true,
    "enable_thinking": false,
    "max_tokens": 20,
    "grammar": {
        "type": "gbnf",
        "grammar": "root ::= [0-9] [0-9] [0-9] [0-9] \"-\" [0-9] [0-9] \"-\" [0-9] [0-9]",
        "root": "root"
    },
    "conversation_history": [
        {
            "role": "user",
            "content": "When did the Apollo 11 mission land on the Moon? Answer with the date only."
        }
    ]
}
```

### Response

```txt
1969-07-20
```

The model is forced to produce a `YYYY-MM-DD` string, with no other additions.

## Forcing structured JSON output (JSON Schema)

Use `json_schema` when you want the model to produce JSON that matches a specific shape. Pass the schema as a string in the `schema` field. Paddler converts it to a GBNF grammar internally.

### Payload

```json
{
    "add_generation_prompt": true,
    "enable_thinking": false,
    "max_tokens": 200,
    "grammar": {
        "type": "json_schema",
        "schema": "{\"type\":\"object\",\"properties\":{\"name\":{\"type\":\"string\"},\"age\":{\"type\":\"integer\"},\"occupation\":{\"type\":\"string\",\"enum\":[\"engineer\",\"teacher\",\"doctor\",\"artist\"]},\"employed\":{\"type\":\"boolean\"},\"hobbies\":{\"type\":\"array\",\"items\":{\"type\":\"string\"}}},\"required\":[\"name\",\"age\",\"occupation\",\"employed\",\"hobbies\"]}"
    },
    "conversation_history": [
        {
            "role": "user",
            "content": "Extract a structured record from: 'John is a 35-year-old engineer who is currently employed and enjoys hiking and chess.'"
        }
    ]
}
```

### Response

```json
{
  "name": "John",
  "age": 35,
  "occupation": "engineer",
  "employed": true,
  "hobbies": ["hiking", "chess"]
}
```

The output is guaranteed to match the schema — the right fields are present, the types line up, and the enum value is one of the allowed options.

## Troubleshooting

If something goes wrong, the stream will end with one of:

- `GrammarSyntaxError` — your JSON Schema could not be parsed or converted to a grammar.
- `GrammarInitializationFailed` — the GBNF grammar could not be loaded by the sampler. This error surfaces invalid GBNF rules and unknown `root` rules, both for `gbnf` requests and for grammars that Paddler generated from your JSON Schema.
- `GrammarIncompatibleWithThinking` — the request had both a grammar and `enable_thinking: true`.
- `GrammarRejectedModelOutput` — the grammar refused to accept a token the model produced.
