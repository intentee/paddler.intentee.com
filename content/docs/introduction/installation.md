+++
title = "Installation"
weight = 4
+++

There are multiple ways to install Paddler. 

The goal is to somehow obtain the `paddler` binary and make it available in your system.

## Obtaining the Paddler binary

### Option 1: Download the latest release

You can download the latest release from our [GitHub releases](https://github.com/intentee/paddler/releases).

### Option 2: Build from source

If your system is not supported by the pre-built binaries (or you just want to build it yourself), you can build Paddler from source.

To do that, follow the steps:

1. Have [Rust](https://www.rust-lang.org/) and [Node](https://nodejs.org/en) installed on your system.
2. Clone our [repository](https://github.com/intentee/paddler) and run `make release` in the root directory of the project.
3. That will produce a `paddler` binary in the `target/release` directory.

## Hardware support

### Cuda 

You need to compile Paddler with the `cuda` feature (`cargo build --features cuda`). 

You need to have the CUDA toolkit installed on your system, and the `nvcc` compiler must be in your `PATH`.

### Metal

Works out of the box on Macs.

### Vulkan

You need to compile Paddler with the `vulkan` feature (`cargo build --features vulkan`).

### Need more? 🙂

Start an issue on [GitHub](https://github.com/intentee/paddler/issues).

## Using Paddler

The entire Paddler functionality is available through the `paddler` command.

You can run `paddler --help` to see the available commands and options.

If you want to install it globally in your system, you can usually move the binary into `/usr/local/bin`, or to a
similar directory that is in your `PATH`. That is very system-specific, though, so it is not viable to cover all the
possible options here. Look up "how to install a binary globally on Linux/Windows/Mac/BSD/*".
