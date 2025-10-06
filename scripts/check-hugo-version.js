const fs = require("fs");
const { execSync } = require("child_process");
const required = fs.readFileSync(".hugo_version", "utf8").trim();
const hugo_full_version = execSync("hugo version").toString();

const installed = hugo_full_version.match(/v[\d.]+/)[0].slice(1);
if (required === installed) {
  console.log(`Installed Hugo version ${installed} is OK.`);
} else
  throw new Error(
    `Installed Hugo version mismatch: required ${required}, but found ${installed}`
  );
