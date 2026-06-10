+++
description = "Load a model into Paddler from Hugging Face, a direct URL, or a local file, and learn where downloaded models are cached and how to clear the cache."
layout = "LayoutDocumentationPage"
title = "Loading models and models cache"

[[collection]]
after = "docs/starting-out/using-web-admin-panel"
name = "documentation_pages"
parent = "docs/starting-out/index"
+++

Before an agent can serve requests, it needs a model. You do not set the model on the agent itself. Instead, you tell the balancer which model you want (this is part of the balancer's *desired state*), and the balancer passes that to every connected agent, which then loads the model.

You can set the model through the API, or through the optional [web admin panel](docs/starting-out/using-web-admin-panel). Once a model is loaded, you can change it at any time without restarting anything (see [Model swapping](docs/starting-out/model-swapping)).

## Where a model can come from

Paddler can load a model from three kinds of source. In the API, the `model` field takes one of the following forms (the same forms also apply to `multimodal_projection` if you're using [multimodal models](docs/starting-out/using-multimodal-models)):

### Hugging Face

```JSON
"model": {
  "HuggingFace": {
    "repo_id": "unsloth/Qwen3.5-0.8B-GGUF",
    "filename": "Qwen3.5-0.8B-Q4_K_M.gguf",
    "revision": "main"
  }
}
```

The agent downloads the file from Hugging Face. Hugging Face files are kept in the standard Hugging Face cache, which is separate from Paddler's own cache.

### A direct download URL

```JSON
"model": {
  "Url": {
    "url": "https://example.com/models/my-model.gguf"
  }
}
```

The agent downloads the file over `http` or `https`. The URL has to be a direct, reachable link to the `.gguf` file with no login required (a server on your local network works too). Downloaded files are kept in Paddler's cache (see the sections below for where to find it and how to clear it).

### A local file on the agent

```JSON
"model": {
  "LocalToAgent": "/path/to/your/model.gguf"
}
```

The agent reads the file directly from its own disk, so nothing is downloaded. If you run a fleet, the file has to exist at that path on every agent that should serve the model.

### No model

```JSON
"model": "None"
```

This leaves the agent without a model loaded.

## Setting the model through the API

Send a [PUT request to change the balancer's desired state](api/management-service/put-balancer-desired-state) with your chosen `model`. For example, to load a Hugging Face model:

```JSON
{
  "chat_template_override": null,
  "inference_parameters": {
    "context_size": 8192,
    "embedding_batch_size": 256,
    "enable_embeddings": false,
    "image_resize_to_fit": 1024,
    "k_cache_dtype": "Q8_0",
    "min_p": 0.05,
    "n_batch": 2048,
    "n_gpu_layers": 0,
    "penalty_frequency": 0.0,
    "penalty_last_n": -1,
    "penalty_presence": 0.8,
    "penalty_repeat": 1.1,
    "pooling_type": "Last",
    "temperature": 0.8,
    "top_k": 80,
    "top_p": 0.8,
    "v_cache_dtype": "Q8_0"
  },
  "model": {
    "HuggingFace": {
      "filename": "Qwen3.5-0.8B-Q4_K_M.gguf",
      "repo_id": "unsloth/Qwen3.5-0.8B-GGUF",
      "revision": "main"
    }
  },
  "multimodal_projection": "None",
  "use_chat_template_override": false
}
```

The agents pick up the change and load the model automatically.

## Setting the model through the web admin panel

If you use the optional web admin panel, you can set the model there instead of calling the API. See [Using the web admin panel](docs/starting-out/using-web-admin-panel) for the full walkthrough.

## Where downloaded models are stored

Models you load from a direct URL are downloaded into Paddler's cache. This cache lives on the machine where the agent runs, because the agents do the downloading, not the balancer. The cache directory is resolved in this order:

- `PADDLER_CACHE_DIR`, if you set it;
- otherwise on Linux/macOS, `$XDG_CACHE_HOME/paddler`, falling back to `~/.cache/paddler`;
- and on Windows, `%LOCALAPPDATA%\paddler`, falling back to `%USERPROFILE%\AppData\Local\paddler`.

Inside Paddler's cache, downloaded models are kept in a `downloaded-models` subdirectory, each file named by a hash of its URL. Hugging Face models are not stored here (they use the Hugging Face cache), and local files are never copied.

## Clearing the Paddler cache

Paddler does not have a built-in command to clear the cache. You clear it by deleting the directory yourself, on each machine that runs an agent. For example, on Linux or macOS with the default location:

```sh
rm -rf ~/.cache/paddler/downloaded-models
```

Because the cached files are named by a hash of the URL rather than by the model name, the practical approach is to delete the whole `downloaded-models` directory instead of picking out individual files. Agents will re-download any model they still need the next time it is requested.

## When loading fails

If an agent cannot load the model, it reports an issue instead of crashing. You can see these issues in the `issues` array of the [Get agents](api/management-service/get-agents) endpoint, or in the web admin panel. Common causes include:

- the Hugging Face repository, file, or revision does not exist, or you do not have permission to download it;
- a direct-URL download cannot be reached, is refused, or the URL is malformed;
- a local file is not present at the given path on the agent;
- the agent's disk is full, or its cache directory is not writable;
- the downloaded file is not a valid GGUF model that the engine can load.
