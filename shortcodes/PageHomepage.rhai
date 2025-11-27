fn template(context, props, content) {
  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <div class="homepage-banner">
          <div class="homepage-banner__content">
            <span class="homepage-banner__event-title">Post Software:</span> Join us at the 1st edition of the Post Software event in Warsaw on 4th February 2026.
          </div>
          <a class="homepage-banner__button" href="https://luma.com/kx2nw3l7" target="_blank">
            Join the event
          </a>
        </div>
        <h1 class="homepage__title">
          Keep AI on your own servers
        </h1>
        <div class="homepage__details">
          <div class="homepage__details__section">
            <h2>What is it?</h2>
            <p>
              Paddler is an open-source LLM load balancer and serving platform that lets teams run inference and deploy LLMs on their own infrastructure.
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
