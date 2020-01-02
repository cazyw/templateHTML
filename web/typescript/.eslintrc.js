module.exports = {
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  extends: ['plugin:@typescript-eslint/recommended', 'plugin:prettier/recommended', 'prettier/@typescript-eslint'],
  parserOptions: {
    project: './tsconfig.json',
    ecmaVersion: 2018,
    sourceType: 'module'
  },
  rules: {
    // Special ESLint rules or overrides go here.
    "no-trailing-spaces": true,
    "no-multiple-empty-lines": ["error", { "max": 2 }]
  }
};
