const { environment } = require('@rails/webpacker')

environment.loaders.append('expose', {
  test: require.resolve('toastr'),
  use: [{
    loader: 'expose-loader',
    options: 'toastr'
  }]
})

module.exports = environment
