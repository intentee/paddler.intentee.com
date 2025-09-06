#!/usr/bin/env node

import { jarmuz } from "jarmuz";

jarmuz({
  once: true,
  pipeline: ["prettier"],
  watch: ["jarmuz", "resources", "*.mjs"],
}).decide(function ({ matches, schedule }) {
  switch (true) {
    case matches("**/*.css"):
    case matches("**/*.mjs"):
    case matches("**/*.ts"):
    case matches("**/*.tsx"):
      schedule("prettier");
      break;
  }
});
