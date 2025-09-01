#!/usr/bin/env node

import { jarmuz } from "jarmuz";

jarmuz({
  once: false,
  pipeline: ["poet-watch", "tcm", "tsc", "esbuild-development"],
  watch: ["poet.toml", "resources", "src"],
}).decide(function ({ matches, schedule }) {
  switch (true) {
    case matches("poet.toml"):
      schedule("poet-watch");
      break;
    case matches("resources/**/*.{ts,tsx}"):
      schedule("tsc");
      break;
    case matches("resources/ts/**/*.css"):
      schedule("tcm");
    case matches("resources/**/*.{avif,css,gif,jpg,jpeg,svg,webp}"):
      schedule("esbuild-development");
      return;
  }
});
