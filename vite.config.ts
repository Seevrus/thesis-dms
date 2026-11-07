import inertia from "@inertiajs/vite";
import { wayfinder } from "@laravel/vite-plugin-wayfinder";
import babel from "@rolldown/plugin-babel";
import react, { reactCompilerPreset } from "@vitejs/plugin-react";
import laravel from "laravel-vite-plugin";
import { bunny } from "laravel-vite-plugin/fonts";
import { defineConfig } from "vite";

// eslint-disable-next-line import-x/no-default-export
export default defineConfig({
  plugins: [
    laravel({
      input: ["resources/css/app.css", "resources/js/app.tsx"],
      refresh: true,
      fonts: [
        bunny("Instrument Sans", {
          weights: [400, 500, 600],
        }),
      ],
    }),
    inertia(),
    react(),
    babel({
      presets: [reactCompilerPreset()],
    }),
    wayfinder({
      formVariants: true,
    }),
  ],
  server: {
    watch: {
      ignored: ["**/.claude/**", "**/vendor/**"],
    },
  },
});
