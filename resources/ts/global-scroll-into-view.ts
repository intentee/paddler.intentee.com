function ready(callback: () => void) {
  if (document.readyState !== "loading") {
    callback();
  } else {
    document.addEventListener("DOMContentLoaded", callback);
  }
}

ready(function () {
  let element = document.querySelector(
    ".documentation-page__menu__link.documentation-page__menu__link--active",
  );

  if (element) {
    (element as unknown as any).scrollIntoViewIfNeeded({
      behavior: "instant",
      container: "nearest",
    });
  }
});
