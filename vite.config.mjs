import { resolve } from 'path'
import { defineConfig } from 'vite'

export default defineConfig({
  esbuild: {
    minifyIdentifiers: false
  },
  build: {
    lib: {
      entry: resolve(__dirname, 'src/index.js'),
      name: 'JetUi',
      fileName: 'jet_ui'
    },
    rollupOptions: {
      external: ['@hotwired/stimulus'],
      output: {
        globals: {
          '@hotwired/stimulus': 'Stimulus'
        }
      }
    }
  }
})
