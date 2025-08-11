import react from '@vitejs/plugin-react-swc'
import { defineConfig } from 'vite'

// https://vite.dev/config/
export default defineConfig({
  base: "/webporta",
  build: {
    outDir: "../public/webporta",
  },
  root: "fe_src",
  plugins: [react()],
})
