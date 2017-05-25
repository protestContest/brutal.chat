let path = require('path');
let webpack = require('webpack');

module.exports = {
  entry: ['./client/entry.js', 'webpack/hot/dev-server', 'webpack-hot-middleware/client'],
  output: {
    path: path.resolve(__dirname, 'public/'),
    publicPath: '/',
    filename: 'app.js'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react', 'stage-2'],
          cacheDirectory: false
        }
      }
    ]
  },
  resolve: {
    extensions: ['.js']
  },
  devServer: {
    historyApiFallback: true
  },
  devtool: 'source-map',
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ]
};