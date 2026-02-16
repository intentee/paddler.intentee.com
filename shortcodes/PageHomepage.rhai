fn template(context, props, content) {
  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <h1 class="homepage__title">
          Keep AI on your own servers
        </h1>
        <div class="homepage__details">
          <div class="homepage__details__section">
            <h2>What is it?</h2>
            <p>
              Paddler is an open-source LLM load balancer and serving platform that lets teams run inference and deploy LLMs on their own infrastructure.
            </p>
            <p>
              <a href="https://fosdem.org/2026/schedule/event/PD8WGF-from_infrastructure_to_production_a_year_of_self-hosted_llms/">Paddler FOSEDM 2026 talk</a> - From Infrastructure to Production: A Year of Self-Hosted LLMs.
            </p>
          </div>
          <div class="homepage__details__section">
            <h2>Who made this?</h2>
            <p>
              This is an open-source project originally started by <a href="https://intentee.com">Intentee</a>.
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
