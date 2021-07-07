const path = require('path');
const { merge } = require('webpack-merge');
const common = require('./webpack.common');

module.exports = merge(common, {
  mode: 'development',
  devtool: 'source-map',
  devServer: {
    contentBase: path.join(__dirname, 'public', 'fe_dist'),
    compress: false,
    hot: true,
    inline: true,
    port: 3000,
    historyApiFallback: true,
  },
  module: {
    rules: [
      {
        test: /\.scss$/i,
        use: [
          'style-loader',
          'css-loader',
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins() {
                  return [
                    // eslint-disable-next-line global-require
                    require('autoprefixer'),
                  ];
                },
              },
            },
          },
          'sass-loader',
        ],
      },
    ],
  },
  optimization: {
    minimize: false,
  },
  target: 'web',
});
