+++
description = "GET /metrics - Get reporting metrics in the Prometheus format."
layout = "LayoutDocumentationPage"
title = "Get metrics"

[[collection]]
after = "api/management-service/put-balancer-desired-state"
name = "api_pages"
parent = "api/management-service/index"
+++

This endpoint allows you to scrape reporting metrics about your current Paddler setup in Prometheus format.

The following metrics are available:
- `paddler_slots_processing` - the number of slots currently processing requests
- `paddler_slots_total` - number of total available slots
- `paddler_requests_buffered` - the number of requests currently buffered

You can read more about the metrics in the [Reporting metrics](docs/starting-out/reporting-metrics) article.

## Endpoint

```
Method: GET
Path: /metrics
```

 ## Response
 
 ```txt
 # HELP paddler_slots_processing Number of processing slots
 # TYPE paddler_slots_processing gauge
 paddler_slots_processing 0
 
 # HELP paddler_slots_total Number of total slots
 # TYPE paddler_slots_total gauge
 paddler_slots_total 2
 
 # HELP paddler_requests_buffered Number of buffered requests
 # TYPE paddler_requests_buffered gauge
 paddler_requests_buffered 0
 ```
