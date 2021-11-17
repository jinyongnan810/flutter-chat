module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: ["eslint:recommended", "google"],
  // could not compile async without this
  parserOptions: {
    ecmaVersion: 8,
  },
  rules: {
    quotes: ["error", "double"],
  },
};
