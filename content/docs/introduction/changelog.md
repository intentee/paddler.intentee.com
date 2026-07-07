+++
description = "Keep track of all the changes in Paddler, including new features, improvements, and bug fixes."
layout = "LayoutDocumentationPage"
title = "Changelog"

[[collection]]
after = "docs/introduction/installation"
name = "documentation_pages"
parent = "docs/introduction/index"
+++

## v4.0.1

### Bug fixes
- Embedding models without a chat template no longer fail to load
- Clear errors when generation is disabled: while a cluster is set to generate embeddings, all generation endpoints reject with a clear "token generation is disabled"
- Web admin panel: the prompt section is disabled while embeddings are enabled

## v4.0.0

### Features

- [Load models from a direct URL](docs/starting-out/loading-models-and-models-cache): provide a direct URL to a .gguf model and Paddler downloads and caches it on the agent
- [OpenAI Responses API](docs/migrating-to-paddler/openai-compatibility): new `/v1/responses` endpoint, alongside `/v1/chat/completions`
- [Token usage and classification](docs/starting-out/token-classification-and-usage-count): responses report per-kind token counts, and generated tokens are classified as content, reasoning, tool call, or undeterminable
- [Structured tool-call parsing](docs/starting-out/using-function-calling): set `parse_tool_calls` to get parsed tool calls 
- New endpoint: [Get balancer applicable state](api/management-service/get-balancer-applicable-state)

### Breaking changes

- Inference parameters: `batch_n_tokens` renamed to `n_batch`
- Inference parameters now requires `embedding_batch_size`
- Streamed tokens now arrive under kind-specific keys (`ContentToken`, `ReasoningToken`, `ToolCallToken`, `UndeterminableToken`) instead of `Token`, and the stream ends with a `Done` event carrying token usage
- Minimum supported Rust version is now 1.95.0

## v3.1.2

### Features

- Continuous batching in the inference engine
- [Paddler desktop application](docs/desktop-app/using-the-desktop-app): manage balancer and agents from a native GUI 
- [Grammars](docs/starting-out/using-grammars): constrain model output with grammars; GBNF and JSON Schema supported

### Breaking changes

- `inference_parameters` no longer accepts `embedding_n_seq_max` (removed)
- `inference_parameters` now requires `k_cache_dtype`, `n_gpu_layers`,  and `v_cache_dtype` fields 


## v3.0.0

### Features

- [Multimodal support](docs/starting-out/using-multimodal-models): include images in conversations using vision-language models in the web admin panel and API

### Breaking changes

- Balancer desired state now requires a `multimodal_projection` field (use `"None"` to disable)
- `inference_parameters` now requires `image_resize_to_fit` field

## v2.2.0

### Features

- Configurable `embedding_n_seq_max` parameter for controlling embedding batch throughput 

### Breaking changes

- `embedding_n_seq_max` is now a required field in `inference_parameters`       

## v2.1.0

### Features

- [OpenAI compatibility](docs/migrating-to-paddler/openai-compatibility) endpoint:
  - Support for `max_completion_tokens` parameter in `/v1/chat/completions` endpoint
  - Support for `messages` parameter in `/v1/chat/completions` endpoint
  - Support for `stream` parameter in `/v1/chat/completions` endpoint

## v2.0.0

**Important** 

<Note>
    This release no longer uses `llama-server`. Instead, we bundle the `llama.cpp` codebase directly into Paddler.
</Note>

We only use `llama.cpp` as a library for inference and have reimplemented `llama-server` functionality within Paddler itself.

Instead of `llama-server`, you can use `paddler agent`, and you no longer need to run `llama-server` separately, which significantly simplifies the setup.

### Features

- `llama.cpp` is now built-in directly into Paddler, no need to run `llama-server` separately
- `paddler agent` command replaces `llama-server` functionality
- Check out the [API](api/introduction/using-paddler-api) page for complete list of changes in the API

## v1.2.0

### Features

- Add TUI dashboard (`paddler dashboard --management-addr [HOST]:[PORT]`) to be able to easily observe balancer instances from the terminal level

## v1.1.0

- More meaningful error messages when the agent can't connect to the llama.cpp slot endpoint, or when slot endpoint is not enabled in llama.cpp
- Set default logging level to `info` for agents and balancer to increase the amount of information in the logs (it wasn't clean if the agent was running or not)
- Enable LTO optimization for the release builds (see [#28](https://github.com/distantmagic/paddler/issues/28))

## v1.0.0

The first stable release! Paddler is now rewritten in Rust and uses the [Pingora](https://github.com/cloudflare/pingora) framework for the networking stack. A few minor API changes and reporting improvements are introduced (documented in the README). API and configuration are now stable, and won't be changed until version `2.0.0`.

This is a stability/quality release. The next plan is to introduce a supervisor who does not just monitor llama.cpp instances, but to also manage them.

Requires llama.cpp version [b4027](https://github.com/ggerganov/llama.cpp/releases/tag/b4027) or above.

## v0.10.0

This update is a minor release to make Paddler compatible with `/slots` endpoint changes introduced in llama.cpp b4027.

Requires llama.cpp version [b4027](https://github.com/ggerganov/llama.cpp/releases/tag/b4027) or above.

## v0.9.0

Latest supported llama.cpp release: [b4026](https://github.com/ggerganov/llama.cpp/releases/tag/b4026)

### Features

- Add `--local-llamacpp-api-key` flag to balancer to support llama.cpp API keys (see: [#23](https://github.com/distantmagic/paddler/issues/23))

## v0.8.0

### Features

- Add `--rewrite-host-header` flag to balancer to rewrite the `Host` header in forwarded requests (see: [#20](https://github.com/distantmagic/paddler/issues/20))

## v0.7.1

### Fixes

- Incorrect preemptive counting of remaining slots in some scenarios

## v0.7.0

Requires at least [b3606](https://github.com/ggerganov/llama.cpp/releases/tag/b3606) llama.cpp release.

### Breaking Changes

- Adjusted to handle breaking changes in llama.cpp `/health` endpoint: https://github.com/ggerganov/llama.cpp/pull/9056
  
    Instead of using the `/health` endpoint to monitor slot statuses, starting from this version, Paddler uses the `/slots` endpoint to monitor llama.cpp instances.
    Paddler's `/health` endpoint remains unchanged.

## v0.6.0

Latest supported llama.cpp release: [b3604](https://github.com/ggerganov/llama.cpp/releases/tag/b3604)

### Features

- [Name agents with `--name` flag](https://github.com/distantmagic/paddler/issues/15)

## v0.5.0

### Fixes

- Management server crashed in some scenarios due to concurrency issues

## v0.4.0

Thank you, [@ScottMcNaught](https://github.com/ScottMcNaught), for the help with debugging the issues! :)

### Fixes

- OpenAI compatible endpoint is now properly balanced (`/v1/chat/completions`)
- Balancer's reverse proxy `panic`ked in some scenarios when the underlying `llama.cpp` instance was abruptly closed during the generation of completion tokens
- Added mutex in the targets collection for better internal slots data integrity

## v0.3.0

### Features

* Requests can queue when all llama.cpp instances are busy
* AWS Metadata support for agent local IP address
* StatsD metrics support

## v0.1.0

### Features

* [Aggregated Health Status Responses](https://github.com/distantmagic/paddler/releases/tag/v0.1.0)
