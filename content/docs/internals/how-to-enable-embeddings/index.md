+++
title = "How to enable embeddings"
weight = 3
+++

You can enable embeddings either in the web admin panel or through API.

## Enabling embeddings in the web admin panel

In the "Model" section, check the `enable_embeddings` checkbox at the bottom of the inference parameters list. You can also select the pooling type from the dropdown. Next, apply your changes.

{{ figure_image(path="enable-embeddings-web.avif", alt="Enabling embeddings in the web admin panel") }}

## Enabling embeddings through API

`enable_embeddings` should be set to `true` in the [PUT request to change the balancer's desired state](@api/management-service/put-balancer-desired-state.md). 

Pooling type can also be specified in that request.
