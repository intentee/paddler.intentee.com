fn template(context, props, content) {

  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <h1 class="homepage__title">
          Paddler
        </h1>
        <h2 class="homepage__subtitle">
          Open-source LLMOps platform for hosting and scaling AI in your own infrastructure. 🏓✨🤖🦙
        </h2>
        <div class="homepage__cta">
          <a href={context.link_to("index")} class="homepage__cta__button homepage__cta__button--primary">
            Get Started
          </a>
          <a href={context.link_to("index")} class="homepage__cta__button">
            Install
          </a>
        </div>
      </div>
    </LayoutMinimal>
  }
}
