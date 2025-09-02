+++
layout = "LayoutDocumentationPage"
title = "How to enable embeddings"

[[collection]]
after = "docs/internals/buffered-requests"
name = "documentation_pages"
parent = "docs/internals/index"
+++

You can enable embeddings either in the web admin panel or through API.

## Enabling embeddings in the web admin panel

In the "Model" section, check the `enable_embeddings` checkbox at the bottom of the inference parameters list. You can also select the pooling type from the dropdown. Next, apply your changes.

<Figure 
    alt="Testing the request to generate tokens"
    src="resources/media/how-to-enable-embeddings/enable-embeddings-web.avif"
/>

## Enabling embeddings through API

`enable_embeddings` should be set to `true` in the [PUT request to change the balancer's desired state](api/management-service/put-balancer-desired-state). 

Pooling type can also be specified in that request.
