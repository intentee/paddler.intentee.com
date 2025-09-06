#!/usr/bin/env node

import { jarmuz } from "jarmuz";

jarmuz({
  once: false,
  pipeline: ["poet-watch", "tcm", "tsc", "esbuild-development"],
  watch: ["resources", "src"],
}).decide(function ({ matches, schedule }) {
  schedule("poet-watch");

  switch (true) {
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
