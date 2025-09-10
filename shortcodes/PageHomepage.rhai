fn template(context, props, content) {
  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <div class="homepage__product-name">
          Paddler by Intentee
        </div>
        <h1 class="homepage__title">
          Keep AI on your own servers
        </h1>
        <div class="homepage__details">
          <div class="homepage__details__section">
            <h2>What is it?</h2>
            <p>
              Paddler is an open-source LLMOps platform that lets teams run
              inference and deploy LLMs on their own infrastructure.
            </p>
          </div>
          <div class="homepage__details__section">
            <h2>Why?</h2>
            <ul class="homepage__benefits">
              <li>Cost control</li>
              <li>Data privacy</li>
              <li>Reliability</li>
              <li>Extensive model support (uses llama.cpp for inference)</li>
            </ul>
          </div>
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
