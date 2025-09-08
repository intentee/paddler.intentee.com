#!/usr/bin/env node

import { jarmuz } from "jarmuz";

jarmuz({
  once: true,
  pipeline: ["tcm", "tsc", "esbuild-development", "poet-generate"],
  watch: ["content", "resources"],
}).decide(function ({ schedule }) {
  schedule("tcm");
});
