const path = require('path');

const root = process.cwd();
const angularAppDir = path.join(root, 'frontend', 'methy-app');
const eslintBin = path.join(angularAppDir, 'node_modules', 'eslint', 'bin', 'eslint.js');
const eslintConfig = path.join(angularAppDir, 'eslint.config.js');

module.exports = {
  // Run dotnet format on staged C# files.
  // dotnet format --include expects relative paths from the repo root.
  // Auto-fix formatting in place (no --verify-no-changes) so the commit
  // always contains properly formatted code.
  '*.cs': (files) => {
    const includes = files
      .map((f) => `--include "${path.relative(root, f).replace(/\\/g, '/')}"`)
      .join(' ');
    return `dotnet format backend/Methy.slnx ${includes}`;
  },

  // Run ESLint and Prettier only on files inside the Angular app.
  // ESLint is installed inside the Angular app; pass --config explicitly so
  // ESLint finds the config regardless of cwd.
  'frontend/methy-app/**/*.{ts,html,scss}': (files) => {
    const fileArgs = files.map((f) => `"${f}"`).join(' ');
    return [
      `node "${eslintBin}" --config "${eslintConfig}" --fix ${fileArgs}`,
      `npx prettier --write ${fileArgs}`,
    ];
  },
};
