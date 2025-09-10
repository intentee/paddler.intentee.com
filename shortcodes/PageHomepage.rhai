fn template(context, props, content) {
  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <div class="homepage__product-name">
        </div>
        <h1 class="homepage__title">
          Keep AI on your own servers
        </h1>
        <div class="homepage__details">
          <h2>What is it?</h2>
          <p>
            <strong>Paddler</strong> is an open-source LLMOps platform for hosting and scaling
            AI on your own infrastructure.
          </p>
          <h2>For whom?</h2>
          <p>Product teams that build AI-based features</p>
          <p>DevOps/LLMOps teams that need to run and scale their AI infrastructure</p>
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
