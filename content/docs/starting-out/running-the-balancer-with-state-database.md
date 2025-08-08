+++
title = "Running the balancer with state database"
weight = 7
+++

Paddler's balancer functions based on specific state. This is simply the collection of inference parameters, the model, and the content of the custom chat template (if a custom chat template is used) used by the balancer.

The state can be defined in the web admin panel or through an HTTP request. However, you can also start the balancer with its desired state specified at startup.


## Starting the balancer with the default state database

By default, the balancer keeps its state in memory. This means:

- On startup, you get the default configuration (default inference parameters, no model, no custom chat template)
- When you shut down Paddler, you lose the state
- The next startup returns to the default configuration

## Starting the balancer with the state database provided as a file option

Instead of keeping state in memory, you can use a state database file saved as JSON.

An example file looks like this:

```json
{
  "balancer_desired_state": {
    "chat_template_override": null,
    "inference_parameters": {
      "batch_n_tokens": 512,
      "context_size": 4096,
      "enable_embeddings": false,
      "min_p": 0.05,
      "penalty_frequency": 0.0,
      "penalty_last_n": -1,
      "penalty_presence": 1.5,
      "penalty_repeat": 1.0,
      "pooling_type": "Last",
      "temperature": 0.6,
      "top_k": 40,
      "top_p": 0.8
    },
    "model": {
      "HuggingFace": {
        "filename": "Qwen3-0.6B-Q8_0.gguf",
        "repo_id": "Qwen/Qwen3-0.6B-GGUF",
        "revision": "main"
      }
    },
    "use_chat_template_override": false
  },
  "version": "1"
}
```

To use this option, start the balancer with the `--state-database` flag and the `file` option pointing to your file path. The balancer will load the state configuration from that file. For example:

```bash
paddler balancer --inference-addr 127.0.0.1:8061 --management-addr 127.0.0.1:8060 --state-database file:///path/to/your/file.json
```

This file will get updated each time you change the desired balancer state (either via the web admin panel or the API). This doesn't work in the other direction, though, meaning that manual changes to the file are not observed by the balancer and will not modify its desired state.

<div class="formatted-text__note"">
    Currently, we only have file and memory drivers. If you need another driver, like an SQL one, feel free to let us know by submitting an issue or a PR.
</div

## Creating the state database file at balancer startup

If you want, you can also run the balancer with the `--state-database` flag and the `file` option even without having the file created beforehand. Running the balancer this way will simply create the state database file with the default configuration of the balancer desired state.
