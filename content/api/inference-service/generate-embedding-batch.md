+++
title = "Generate embedding batch"
weight = 3
+++

This endpoint allows you to generate batches of embeddings for a given content.

## Endpoint

```
Method: POST
Path: /api/v1/generate_embedding_batch
```

## Payload

```JSON
{
  "input_batch": [
    {
      "id": "1",
      "content": "This is how we should keep our company cats happy"
    }
  ],
  "normalization_method": "L2"
}
```

### Parameters

#### `input_batch`

An array of objects, each containing an ID and content for which the embedding should be generated.

The ID is what will allow you to match the generated embedding with the original content later.


#### `normalization_method` 

This is how Paddler normalizes the generated embedding before it's sent back to you. Possible values are:
- `"L2"`
- `"None"`
- `{ "RmsNorm": { "epsilon": 0.001 } }`
