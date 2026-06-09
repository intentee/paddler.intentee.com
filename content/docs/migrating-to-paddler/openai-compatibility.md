+++
description = "Run Paddler with OpenAI-style API compatibility service for an easier migration from OpenAI to self-hosted models."
layout = "LayoutDocumentationPage"
title = "OpenAI compatibility"

[[collection]]
name = "documentation_pages"
parent = "docs/migrating-to-paddler/index"
+++

## How to use OpenAI-style API?

First, you can check how to [setup a basic llm cluster](docs/starting-out/set-up-a-basic-llm-cluster).

Then, to start Paddler with an OpenAI-style API service, you can add the `--compat-openai-addr` parameter to the
`paddler balancer` command. This will start the compatibility service that will listen on the specified address and port.

```bash
paddler balancer 
    --compat-openai-addr 127.0.0.1:8070
    --inference-addr 127.0.0.1:8061 
    --management-addr 127.0.0.1:8060
```

It is intentionally started at a separate address from the main inference service, to prevent any conflicts with the endpoint, and parameter names.

It still uses exactly the same Paddler stack internally (with [buffered requests](docs/internals/buffered-requests), 
[chat templates](docs/internals/chat-templates), etc.), so you can use all the features of Paddler. The only difference
is the format of the requests and responses, and the API endpoints. 

## How does it work?

Internally, all those compatibility endpoints do is map the request parameters and responses back and 
forth between the OpenAI-style API and Paddler's internal API, so you do not need any additional configuration in your
setup.

For example, if you used `--compat-openai-addr 127.0.0.1:8070`, you can find their completions endpoint at:
`http://127.0.0.1:8070/v1/chat/completions` and the responses endpoint at `http://127.0.0.1:8070/v1/responses`.

## Current status

Maintaining compatibility with OpenAI's API is a perpetually ongoing task because we need to keep up with 
their updates and changes. 

Luckily, they do not update their API very often, but still, this is something to keep in mind.

<table>
    <thead>
        <tr>
            <th>Endpoint</th>
            <th>Supported parameters</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <a 
                    href="https://developers.openai.com/api/reference/resources/chat/subresources/completions/methods/create"
                    target="_blank"
                ><code>/v1/chat/completions</code></a>
            </td>
            <td>
                <ul>
                    <li><code>max_completion_tokens</code></li>
                    <li><code>messages</code></li>
                    <li><code>stream</code></li>
                    <li><code>stream options</code></li>
                    <li><code>tools</code></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                <a 
                    href="https://developers.openai.com/api/reference/resources/responses/methods/create"
                    target="_blank"
                ><code>/v1/responses</code></a>
            </td>
            <td>
                <ul>
                    <li><code>input</code></li>
                    <li><code>instructions</code></li>
                    <li><code>max_output_tokens</code></li>
                    <li><code>reasoning</code></li>
                    <li><code>stream</code></li>
                    <li><code>text</code></li>
                    <li><code>tools</code></li>
                </ul>
            </td>
        </tr>        
        <tr>
            <td colspan="2">
                <p>
                    🫵💪❤️ You can help us improve the compatibility! 😊
                </p>
                <p>
                    Check out the
                    <a 
                        href="https://github.com/intentee/paddler/issues?q=is%3Aissue%20state%3Aopen%20label%3Acompatibility%20label%3Aopenai"
                    >GitHub issues</a>, or add your own.
                </p>
            </td>
        </tr>
    </tbody>
</table>

## Contributing

In Paddler 2.1, we provided some libraries and tools in the code to make it easier to contribute to the compatibility
efforts. If you want to start helping us, you can check out the
[GitHub issues tagged with the "compatibility" label](https://github.com/intentee/paddler/issues?q=is%3Aissue%20state%3Aopen%20label%3Acompatibility%20label%3Aopenai).
