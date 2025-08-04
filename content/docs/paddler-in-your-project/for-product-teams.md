+++
title = "For product teams"
weight = 2
+++

Product teams building AI-based features can use Paddler to get LLM responses. Paddler comes with inference capabilities and exposes WebSocket and HTTP REST APIs, so you can make direct requests from your application wherever you need a response from an LLM.

Paddler also gives you a lot of control over the quality of the responses. You can use your own chat template, system prompts, and customize the inference parameters directly in Paddler.

<div class="formatted-text__note">
    The quality of LLM responses directly impacts your product's user experience. Paddler gives you control over that quality, allowing you to use your own chat template, add custom system prompts, and customize the inference parameters directly in Paddler. 
</div>

## Using the Inference Service

Paddler provides the inference based on a built-in llama.cpp engine and enables it via the Inference Service. 

You have two options for sending requests:
1. Using `GenerateTokens` for new, isolated completion requests. You can use it to send an individual prompt to the LLM for a single completion task when you don't need to provide any conversation context.
2. Using `ContinueConversation` for continued conversations. You should use this option if you need to achieve a multi-turn conversation and maintain the conversation context.

## Sending requests through a WebSocket connection

## Sending requests through REST API
