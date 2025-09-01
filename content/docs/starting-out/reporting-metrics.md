+++
layout = "LayoutDocumentationPage"
title = "Reporting Metrics"

[[collection]]
after = "docs/starting-out/managing-paddler-through-api"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Paddler provides reporting metrics to help you monitor your setup. You can either scrap the `/metrics` endpoint to obtain metrics in the Prometheus format, or ask Paddler to push StatsD metrics to a given address.

## Provided metrics

You can obtain the following metrics:
- `paddler_slots_processing` - the number of slots currently processing requests
- `paddler_slots_total` - number of total available slots
- `paddler_requests_buffered` - the number of requests currently buffered

### Metrics prefix

By default, Paddler reports the metrics with the `paddler_` prefix, but you can change this prefix when running the balancer with the `--statsd-prefix` flag. 

For example, if you set the prefix to `foo_` running this command:
```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --statsd-prefix foo_
```

you will receive the following:
- `foo_slots_processing`
- `foo_slots_total`
- `foo_requests_buffered`

## Prometheus format metrics

Paddler exposes the [Get metrics](api/management-service/get-metrics) endpoint you can scrape to obtain metrics in the Prometheus format.

```
Method: GET
Path: /metrics
```

## StatsD metrics

If enabled, Paddler will send metrics to your StatsD server as gauge values. You can enable this when running the balancer with the `--statsd-addr` flag, for example:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --statsd-addr 127.0.0.1:8125
```
