+++
title = "For product teams"
weight = 2
+++

Product teams building AI-based features can use Paddler to get LLM responses. Paddler comes with inference capabilities and exposes WebSocket and HTTP REST APIs, so you can make direct requests from your application wherever you need a response from an LLM.

## Using the Inference Service

Paddler provides the inference based on a built-in llama.cpp engine and enables it via the Inference Service. 

You have two options for sending requests:
1. Using `ContinueFromConversationHistory` for continued conversations. This option takes the conversation history, applies it to the chat templates, and sends it to the LLM. It's useful for multi-turn conversations where you want to maintain context. It's also important because this is the option that uses the chat template to ensure high-quality responses. It is the recommended way for most use cases.
2. Using `ContinueFromRawPrompt`. This option takes your raw prompt and sends it to the LLM without applying any chat templates. This is useful as a workaround if, for whatever reason, you cannot use the chat template.

## Why LLM response quality varies 

<div class="formatted-text__note">
    Remember that the way the LLM responds to your end users' queries and commands has a direct impact on the overall user experience of your product. Paddler gives you control over that quality, allowing you to use your own chat template, add custom system prompts, and customize the inference parameters directly in Paddler. 
</div>

Depending on factors such as chat template used, provided system prompt, or inference parametrs, you can expect different response quality from the same model. We discuss this topic in detail in the [How to control response quality](/docs/best-practices/how-to-control-response-quality/) article.
