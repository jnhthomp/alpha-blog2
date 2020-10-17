const { environment } = require('@rails/webpacker')

// Webpack needed for bootstrap
const webpack = require("webpack")

// jquery and popper.js needed for bootstrap
environment.plugins.append("Provide", new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

module.exports = environment
