fn template(context, props, content) {
  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <h1 class="homepage__title">
          Keep AI on your own servers
        </h1>
        <div class="homepage__details">
          <div class="homepage__subtitle">
            <strong>Paddler</strong> is an open-source LLMOps platform for hosting and scaling
            AI on your own infrastructure.
          </div>
          <ul class="homepage__benefits">
            <li>Cost-control</li>
            <li>Privacy</li>
            <li>Reliability</li>
            <li>Extensive models support (uses llama.cpp for inference with our own infra stack on top)</li>
          </ul>
          <div class="homepage__cta">
            <a href={context.link_to("#docs-initial-page")} class="homepage__cta__button homepage__cta__button--primary">
              Get Started
            </a>
            <a href={context.link_to("docs/introduction/installation")} class="homepage__cta__button">
              Install
            </a>
          </div>
        </div>
      </div>
    </LayoutMinimal>
  }
}
