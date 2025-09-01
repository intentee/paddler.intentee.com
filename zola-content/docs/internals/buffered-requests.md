+++
title = "Buffered requests"
weight = 2
+++

If there are no available slots in agents, Paddler will buffer the incoming requests. There are two key aspects to buffering you can customize: 
- The maximum number of requests that can be buffered `--max-buffered-requests`
- The maximum time the requests can spend in the buffer `--buffered-request-timeout` 

You can customize both when setting up the balancer on your server.

## Video version

<iframe height="315" src="https://www.youtube.com/embed/aJqPd5qSQ9c?si=D1yzk7L6cSIKWNbr" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## The maximum number of buffered requests

If the maximum number of buffered requests is reached, the balancer will start rejecting new requests with the 503 error ([Service Unavailable](https://http.cat/status/503)). The default value is 30, but you can change it by passing the `--max-buffered-requests` flag when starting the balancer. For example, to set the maximum number of buffered requests to 100, run:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --max-buffered-requests 100
```

## The maximum time a request can stay in the buffer

This time is the maximum time a request can stay in the buffer before it times out with the 504 error ([Gateway Timeout](https://http.cat/status/504)). The value is provided in milliseconds. The default is 10000 (10 seconds), but you can change it by passing the `--buffered-request-timeout` flag when starting the balancer. For example, to set the maximum time a request can stay in the buffer to 30 seconds, run:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --buffered-request-timeout 30000
```

The entire request can take more than the `--buffered-request-timeout` time - this value only applies to the time the request spends in the buffer. Once the request is dequeued from the buffer, it will be processed normally, and the time won't be limited anymore. 

For example, once the request starts to respond with inference tokens, it means it is no longer in the buffer and can take as long as it needs to finish processing.


## Buffering requests when generating embeddings

Requests that generate embeddings are also load-balanced and buffered by Paddler. 

Because these requests can take much more time to get processed than token generation, you will likely need to increase the `--max-buffered-requests` and `--buffered-request-timeout` parameters by a lot when you need to generate embeddings.

## Buffering requests and autoscaling groups

Buffering is useful not only during periods of high traffic, but it can also be used with autoscaling groups (including scaling from zero hosts). For example, if you have an autoscaler setting up an additional server, putting the incoming requests on hold in the buffer might give them a chance to be handled even though there might be no available instance with an agent at the moment the requests were issued.

A specific use case is when you have an autoscaling group that scales up from zero hosts. In this case, the balancer will buffer the requests until an instance is started. This is particularly useful when you have a low traffic environment (like a staging server) where you don't want to have expensive GPU instances running all the time, but you still want to be able to handle requests when they come in.
