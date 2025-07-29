+++
title = "Usage"
weight = 3
+++

Paddler is a platform for deployment, scaling, usage of open source LLMs .

a load balancer built specifically for LLM inference workloads. Written in Rust and based on llama.cpp, it handles the unique requirements of LLM deployment and scaling.

## Why Paddler?

Serving LLM inference utilizes continuous batching algorithms and slot-based management, which makes typical load balancing techniques like round robin and least connections ineffective.

Paddler is designed specifically to account for the LLM-unique requirements. It uses llama.cpp as the inference engine and comes with its own llama.cpp server implementation and a built-in slot management for easy setup.

## How it works?

Text
Serving LLM inference utilizes continuous batching algorithms and slot-based management, which makes typical load balancing techniques like round robin and least connections ineffective.
