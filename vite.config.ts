import react from '@vitejs/plugin-react-swc'
import { defineConfig } from 'vite'

// https://vite.dev/config/
export default defineConfig({
  build: {
    outDir: "../public/fe_dist",
  },
  root: "fe_src",
  plugins: [react()],
})
