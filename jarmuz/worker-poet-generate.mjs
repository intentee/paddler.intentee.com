import { spawner } from "jarmuz/job-types";

spawner(function ({ baseDirectory, command }) {
  return command(`
      poet generate ${baseDirectory}
        --output-directory public
        --public-path https://paddler.intentee.com/
    `);
});
