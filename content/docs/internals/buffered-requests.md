+++
title = "Buffered requests"
weight = 3
something = 5121
+++

If there are no available slots in agents, Paddler will buffer the incoming requests. There are two key aspects to buffering you can customize: 
- the maximum number of requests that can be buffered (`max_buffered_requests`) 
- the maximum time the requests can spend in the buffer (`buffered_request_timeout`). 

Both can be customized when setting up the balancer on your server.

## The maximum number of buffered requests

If the maximum number of buffered requests is reached, the balancer will start rejecting new requests with the 429 error (Too Many Requests). The default value is 30, but you can change it by passing the `--max-buffered-requests` flag when starting the balancer. For example, to set the maximum number of buffered requests to 100, run:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --max-buffered-requests 100
```

## The maximum time a request can stay in the buffer

This time is the maximum time a request can stay in the buffer before it times out with the 504 (Gateway Timeout) error. The value is provided in milliseconds. The default is 10000 (10 seconds), but you can change it by passing the `--buffered-request-timeout` flag when starting the balancer. For example, to set the maximum time a request can stay in the buffer to 30 seconds, run:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --buffered-request-timeout 30000
```

## Buffering requests and autoscaling groups

Buffering is useful not only during periods of high traffic, but it can also be used with autoscaling groups (including scaling from zero hosts). For example, if you have an autoscaler setting up an additional server, putting the incoming requests on hold in the buffer might give them a chance to be handled even though there might be no available instance with an agent at the moment the requests were issued.

A specific use case is when you have an autoscaling group that scales up from zero hosts. In this case, the balancer will buffer the requests until an instance is started. This is particularly useful when you have a low traffic environment (like a staging server) where you don't want to have expensive GPU instances running all the time, but you still want to be able to handle requests when they come in.
