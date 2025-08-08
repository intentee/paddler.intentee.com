+++
title = "Reporting metrics"
weight = 9
+++

Paddler provides reporting metrics to help you monitor your setup. You can either scrap the `/metrics` endpoint to obtain metrics in the Prometheus format, or ask Paddler to push StatsD metrics to a given address.

## Provided metrics

You can obtain the following metrics:
- `slots_processing` - the number of slots currently processing requests
- `slots_total` - number of total available slots
- `requests_buffered` - the number of requests currently buffered


## Prometheus format metrics

Paddler exposes the `/metrics` endpoint you can scrap to obtain metrics in the Prometheus format.

```
Method: GET
Path: /metrics
```

## StatsD metrics

If enabled, Paddler will send metrics to your StatsD server as gauge values. You can enable this when running the balancer with the `--statsd-addr` flag, for example:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --statsd-addr 127.0.0.1:8125
```
