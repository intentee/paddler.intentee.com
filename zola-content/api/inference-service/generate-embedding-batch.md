+++
title = "Generate embedding batch"
weight = 3
+++

This endpoint allows you to generate batches of embeddings for a given content. To use it, you need first to ensure you have embeddings enabled (see: [How to enable embeddings](@/docs/internals/how-to-enable-embeddings/index.md) for more information).

You need to give each document a unique ID because the embedding will not be returned in the same order as in the input. 
This is because the agents will generate the embeddings in parallel. To match them with your original documents, you need to match `source_document_id` field in the resulting endpoint with the `id` field of your input document.

Paddler will divide the input batch roughly into context-size chunks and distribute them evenly between the available agents.

Those requests use the Paddler's buffer, so if you need to generate a lot of embeddings, you likely need to increase the `--max-buffered-requests` and `--buffered-request-timeout` parameters of the balancer by a lot.

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

The ID will let you later match each generated embedding with its original content.


#### `normalization_method` 

This is how Paddler normalizes the generated embedding before it's sent back to you. Possible values are:
- `"L2"`
- `"None"`
- `{ "RmsNorm": { "epsilon": 0.001 } }`

## Response

### Success

```JSON
{
  "Response": {
    "request_id": "123456",
    "response": {
      "Embedding": {
        "Embedding": {
          "embedding": [
            0.007884996,
            // ...,
            -0.030835055
          ],
          "normalization_method": "L2",
          "pooling_type": "Last",
          "source_document_id": "1"
        }
      }
    }
  }
}
```

The last token that ends the stream is:

```JSON
{
  "Response": {
    "request_id": "123456",
    "response": {
      "Embedding": "Done"
    }
  }
}
```

### Error

You need to have the `enable_embeddings` option enabled when sending the request. If not enabled, you will get the [501 error (Not Implemented)](https://http.cat/status/501).
