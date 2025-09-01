+++
title = "Chat templates"
weight = 5
+++

A chat template is the specific way a model expects to receive conversations. Using the correct chat templates is one of the most important things you can do to ensure proper response quality from the model - we discuss this topic in the [How to control response quality](@/docs/best-practices/how-to-control-response-quality/index.md) section.

Many models have their chat templates built in, and Paddler uses these templates by default.

If you want to use your own chat template, you can set it up in the web admin panel or through API.

## Adding the chat template in the web admin panel

In the "Model" section, select the "Use my chat template" option, and then click the "Edit chat template" button to add your own template.

## Adding the chat template through API

Use the [Balancer desired state endpoint](@/api/management-service/put-balancer-desired-state.md) to provide your template.
