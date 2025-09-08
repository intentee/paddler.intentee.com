fn template(context, props, content) {
  context.assets.add("resources/css/page-businesses.css");

  component {
    <LayoutMinimal>
      <div class="formatted-text page-businesses">
        <h1 class="docs__title">
          {context.front_matter.title}
        </h1>
        {content}
      </div>
    </LayoutMinimal>
  }
}
