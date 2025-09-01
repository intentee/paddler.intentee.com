+++
layout = "LayoutDocumentationPage"
title = "CORS configuration"

[[collection]]
after = "docs/internals/how-to-enable-embeddings"
name = "documentation_pages"
parent = "docs/internals/index"
+++

You can add CORS rules for clients that need to access the inference service and the management service. Both can be defined when running the balancer.

## Adding CORS rules for the inference service

To add hosts that need to be able to access the inference service, run the balancer with the `--inference-cors-allowed-host` flag, followed by the host's address, for example:

```bash
paddler balancer 
    --inference-addr 127.0.0.1:8061 
    --management-addr 127.0.0.1:8060 
    --inference-cors-allowed-host foo.example.com
    --inference-cors-allowed-host bar.example.com
    --inference-cors-allowed-host example.com
```

You can add multiple hosts by repeating the `--inference-cors-allowed-host` flag.

## Adding CORS rules for the management service

To add hosts that need to be able to access the management service, run the balancer with the `--management-cors-allowed-host` flag, followed by the host's address, for example:

```bash
paddler balancer 
    --inference-addr 127.0.0.1:8061 
    --management-addr 127.0.0.1:8060 
    --management-cors-allowed-host example.com
```

Just like with the inference service, you can add multiple hosts by repeating the `--management-cors-allowed-host` flag.
