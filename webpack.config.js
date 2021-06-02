const path = require('path');

module.exports = {
  entry: ['./client/entry.js'],
  output: {
    path: path.resolve(__dirname, 'public/'),
    publicPath: '/',
    filename: 'app.js'
  },
  devServer: {
    port: 3000,
    watchContentBase: true
  },
  module: {
    rules: [
      {
        test: /\.js|\.jsx$/,
        exclude: /node_modules/,
        use: ['babel-loader', 'source-map-loader']
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  },
}
