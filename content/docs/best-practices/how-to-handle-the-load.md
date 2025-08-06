+++
title = "How to handle the load"
weight = 2
+++

## Setting the appropriate number of slots

Generally, the optimal way is to run each agent on a separate device and give it some slots to handle the incoming requests concurrently. 

It's up to you to define how many slots each agent should have, and it's best to run some benchmarks to determine that number. Start with something on the lower range, like 4 or 8, and observe how the incoming requests are handled.

If all slots are busy, Paddler's balancer will start buffering the incoming requests, which is another aspect of handling the load you can customize.

## Buffering requests

There are two things about the buffer you can customize:

- The maximum number of requests that can be buffered `--max-buffered-requests` (default value is 30 requests)
- The maximum time the requests can spend in the buffe `--buffered-request-timeout` (default value is 10,000 milliseconds)

Paddler starts with some default values, but you can customize both of these numbers when starting the balancer.

### Customizing the buffer

The maximum number of requests is the requests limit the buffer can keep inside at a given moment. Once this number is reached, all new requests will be rejected with the 503 error ([Service Unavailable](https://http.cat/status/503)).

You can run some benchmarks by changing this number when running the balancer with the `--max-buffered-requests` flag, for example:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --max-buffered-requests 100
```

The maximum number of requests in the buffer should be set in a close relation to the maximum time a request can stay in the buffer before it times out and gets dropped (with the 504 error ([Gateway Timeout](https://http.cat/status/504))). You can adjust it when running the balancer with the `--buffered-request-timeout` flag (the value is provided in milliseconds):

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --buffered-request-timeout 30000
```
