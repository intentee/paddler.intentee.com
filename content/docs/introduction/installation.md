+++
description = "Install Paddler by obtaining its binary from GitHub releases or by building it from source, including hardware acceleration support for CUDA, Metal, and Vulkan."
layout = "LayoutDocumentationPage"
title = "Installation"

[[collection]]
after = "docs/introduction/before-you-begin"
name = "documentation_pages"
parent = "docs/introduction/index"
+++

There are multiple ways to install Paddler.

The goal is to somehow obtain the `paddler` binary and make it available in your system.

## Obtaining the Paddler binary

### Option 1: Download the latest release

You can download the latest release from our [GitHub releases](https://github.com/intentee/paddler/releases).

### Option 2: Build from source

If your system is not supported by the pre-built binaries (or you just want to build it yourself), you can build Paddler from source. Paddler current MSRV is *1.88.0*.

To do that:

1. Have [Rust](https://www.rust-lang.org/) and [Node](https://nodejs.org/en) installed on your system.
2. Clone our [repository](https://github.com/intentee/paddler).
3. From the root directory of the project, run the build command for your hardware.

<table>
    <thead>
        <tr>
            <th>Hardware</th>
            <th>Build command</th>
            <th>Binary path</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>CPU</td>
            <td><code>make</code></td>
            <td><code>target/release/paddler</code></td>
        </tr>
        <tr>
            <td>Cuda</td>
            <td><code>make target/cuda/release/paddler</code></td>
            <td><code>target/cuda/release/paddler</code></td>
        </tr>
        <tr>
            <td>Metal</td>
            <td><code>make target/metal/release/paddler</code></td>
            <td><code>target/metal/release/paddler</code></td>
        </tr>
        <tr>
            <td>Vulkan</td>
            <td><code>make target/vulkan/release/paddler</code></td>
            <td><code>target/vulkan/release/paddler</code></td>
        </tr>
    </tbody>
</table>

<Note>
    To build with Cuda, you also need to have the CUDA toolkit installed on your system, and the `nvcc` compiler must be in your `PATH`.
</Note>


#### Need more? 🙂

Start an issue on [GitHub](https://github.com/intentee/paddler/issues).

## Using Paddler

The entire Paddler functionality is available through the `paddler` command.

You can run `paddler --help` to see the available commands and options.

If you want to install it globally in your system, you can usually move the binary into `/usr/local/bin`, or to a
similar directory that is in your `PATH`. That is system-specific, though, so it is not viable to cover all the
possible options here. Look up "how to install a binary globally on Linux/Windows/Mac/BSD/*".
