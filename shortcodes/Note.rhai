fn template(context, props, content) {
  context.assets.add("resources/css/component-note.css");

  component {
    <div
      class={if "type" in props {
        `note note--${props.type}`
      } else {
        "note"
      }}
    >
      {content}
    </div>
  }
}
