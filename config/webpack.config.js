const path = require('path');

module.exports = {
  entry: './src/index.js', // エントリーポイント
  output: {
    filename: 'bundle.js', // 出力されるバンドルファイルの名前
    path: path.resolve(__dirname, 'dist'), // 出力ディレクトリ
  },
  module: {
    rules: [
      {
        test: /\.js$/, // .jsファイルに対する処理
        exclude: /node_modules/, // node_modulesディレクトリを除外
        use: {
          loader: 'babel-loader', // Babelローダーを使用
        },
      },
    ],
  },
  devServer: {
    contentBase: path.join(__dirname, 'dist'), // 開発サーバーのルートディレクトリ
    compress: true,
    port: 9000, // 開発サーバーのポート
  },
};
