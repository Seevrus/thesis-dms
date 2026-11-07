// @ts-check

import eslint from "@eslint/js";
import json from "@eslint/json";
import vitest from "@vitest/eslint-plugin";
import { defineConfig } from "eslint/config";
import eslintConfigPrettier from "eslint-config-prettier";
import { createTypeScriptImportResolver } from "eslint-import-resolver-typescript";
import { importX } from "eslint-plugin-import-x";
import jestDom from "eslint-plugin-jest-dom";
import promisePlugin from "eslint-plugin-promise";
import react from "eslint-plugin-react";
import reactHooks from "eslint-plugin-react-hooks";
import simpleImportSort from "eslint-plugin-simple-import-sort";
import sonarjs from "eslint-plugin-sonarjs";
import testingLibrary from "eslint-plugin-testing-library";
import unicorn from "eslint-plugin-unicorn";
import globals from "globals";
import tseslint from "typescript-eslint";

export default defineConfig(
  {
    languageOptions: {
      ecmaVersion: "latest",
      globals: globals.builtin,
      parserOptions: {
        ecmaFeatures: {
          jsx: true,
        },
        extraFileExtensions: [".js", ".json", ".mjs"],
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
      sourceType: "module",
    },
    settings: {
      "import-x/extensions": [".js", ".ts"],
      "import-x/parsers": {
        "@typescript-eslint/parser": [".ts", ".tsx"],
      },
      "import-x/resolver-next": [
        createTypeScriptImportResolver({
          alwaysTryTypes: true,
          project: ["tsconfig.json"],
        }),
      ],
      react: {
        version: "detect",
      },
    },
  },
  eslintConfigPrettier,
  {
    files: ["**/*.json"],
    language: "json/json",
    plugins: { json },
    extends: ["json/recommended"],
  },
  {
    plugins: {
      "simple-import-sort": simpleImportSort,
    },
    rules: {
      "simple-import-sort/imports": "error",
      "simple-import-sort/exports": "error",
    },
  },
  {
    files: ["**/*.{js,jsx,ts,tsx}"],
    plugins: {
      unicorn,
    },
    rules: {
      "unicorn/filename-case": [
        "error",
        {
          cases: {
            camelCase: true,
            kebabCase: true,
            pascalCase: true,
          },
        },
      ],
      "unicorn/no-array-callback-reference": "off",
      "unicorn/no-array-for-each": "off",
      "unicorn/no-array-reduce": "off",
      "unicorn/no-await-expression-member": "off",
      "unicorn/no-nested-ternary": "off",
      "unicorn/no-null": "off",
      "unicorn/no-useless-switch-case": "off",
      "unicorn/no-useless-undefined": [
        "error",
        {
          checkArguments: false,
        },
      ],
      "unicorn/name-replacements": [
        "error",
        {
          replacements: {
            args: false,
            curr: false,
            env: false,
            idx: false,
            opts: false,
            params: false,
            prev: false,
            prod: false,
            prop: false,
            props: false,
            ref: false,
          },
        },
      ],
    },
  },
  {
    files: ["resources/js/**/*", "vite.*.ts", "vitest.*.ts*"],
    ...react.configs.flat.recommended,
    ...reactHooks.configs.flat.recommended,
    extends: [
      eslint.configs.recommended,
      jestDom.configs["flat/recommended"],
      importX.flatConfigs.recommended,
      promisePlugin.configs["flat/recommended"],
      sonarjs.configs.recommended,
      ...tseslint.configs.recommendedTypeChecked,
      ...tseslint.configs.stylisticTypeChecked,
    ],
    plugins: {
      promise: promisePlugin,
      react,
      "react-hooks": reactHooks,
    },
    rules: {
      "@typescript-eslint/consistent-type-definitions": ["error", "type"],
      "@typescript-eslint/consistent-type-exports": [
        "error",
        {
          fixMixedExportsWithInlineTypeSpecifier: true,
        },
      ],
      "@typescript-eslint/consistent-type-imports": [
        "error",
        {
          fixStyle: "inline-type-imports",
          prefer: "type-imports",
        },
      ],
      "@typescript-eslint/no-floating-promises": "off",
      "@typescript-eslint/no-unused-vars": [
        "warn",
        {
          argsIgnorePattern: "^_",
          varsIgnorePattern: "^_",
        },
      ],
      "@typescript-eslint/unbound-method": "off",
      "arrow-body-style": ["error", "as-needed"],
      "default-param-last": "error",
      "import-x/first": "error",
      "import-x/newline-after-import": "error",
      "import-x/no-cycle": ["error", { ignoreExternal: true }],
      "import-x/no-default-export": "error",
      "import-x/no-duplicates": "error",
      "max-params": "error",
      "no-console": "warn",
      "no-debugger": "error",
      "no-nested-ternary": "error",
      "no-unneeded-ternary": "error",
      "prefer-arrow-callback": "error",
      "promise/always-return": "off",
      "promise/catch-or-return": "off",
      "sonarjs/cognitive-complexity": "off",
      "sonarjs/function-return-type": "off",
      "sonarjs/no-redundant-jump": "off",
    },
  },
  {
    files: ["resources/js/**/*.d.ts"],
    rules: {
      "@typescript-eslint/consistent-type-definitions": "off",
      "@typescript-eslint/no-unused-vars": "off",
    },
  },
  {
    files: ["resources/js/**/*.{spec,test}.{ts.tsx}"],
    ...testingLibrary.configs["flat/react"],
    languageOptions: {
      globals: {
        ...vitest.environments.env.globals,
      },
    },
    plugins: {
      vitest,
    },
    rules: {
      ...vitest.configs.all.rules,
      "@typescript-eslint/no-unsafe-assignment": "off",
      "@typescript-eslint/no-unsafe-call": "off",
      "@typescript-eslint/no-unsafe-member-access": "off",
      "sonarjs/no-hardcoded-passwords": "off",
      "sonarjs/no-nested-functions": "off",
      "vitest/consistent-test-filename": [
        "warn",
        {
          pattern: ".*\\.test\\.ts$",
        },
      ],
      "vitest/consistent-test-it": [
        "warn",
        {
          fn: "test",
          withinDescribe: "test",
        },
      ],
      "vitest/expect-expect": [
        "warn",
        { assertFunctionNames: ["assert*", "expect*"] },
      ],
      "vitest/max-expects": "off",
      "vitest/no-hooks": "off",
      "vitest/prefer-expect-assertions": "off",
      "vitest/prefer-lowercase-title": "off",
    },
  },
  {
    ignores: [
      "app/",
      "bootstrap/",
      "config/",
      "database/",
      "node_modules/",
      "resources/js/actions",
      "resources/js/routes",
      "resources/js/wayfinder",
      "route/",
      "storage/",
      "tests/",
      "vendor/",
    ],
  },
);
