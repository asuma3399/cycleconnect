# アプリケーション名
CycleConnect

# アプリケーション概要
[![Image from Gyazo](https://i.gyazo.com/afdea41a907c8c5fcdde1c81caeaf0a8.png)](https://gyazo.com/afdea41a907c8c5fcdde1c81caeaf0a8)<br>
・サイクリングで撮影した写真を撮影地の位置情報付きでシェアをし、コミュニケーションをとる。<br>
・グループでチャットをしながらイベント企画機能でライドイベントを企画する

# URL
https://cycleconnect.onrender.com


# テスト用アカウント
・Basic認証パスワード：2222<br>
・Basic認証ID：admin<br>
・メールアドレス：test1@test.com<br>
・パスワード：111111

# 利用方法
## 写真投稿
1. トップページからユーザー新規登録を行う<br>
2. Galleryページの新規写真投稿ボタンから、投稿の内容（写真の詳細、タグ、投稿する写真、緯度・経度）を入力し投稿する<br>
※写真に緯度・経度の情報が含まれている場合、緯度・経度の入力は不要<br>
[![Image from Gyazo](https://i.gyazo.com/5708fad4a7888b070f83ffc426358c0f.gif)](https://gyazo.com/5708fad4a7888b070f83ffc426358c0f)

## 投稿された写真を確認する
1. Galleryページから投稿された写真をクリックして、写真の詳細を確認する<br>
2. 良いと思った投稿があれば、いいねボタンをクリックする<br>
3. コメントしたい投稿があれば、コメント入力欄からコメントを投稿する
[![Image from Gyazo](https://i.gyazo.com/1113fec92007165ecddf92313c289ff6.gif)](https://gyazo.com/1113fec92007165ecddf92313c289ff6)
4. ユーザー名をクリックして、ユーザーのプロフィール（ユーザー名、自己紹介文、投稿写真（直近5枚）、参加予定のイベント（5回分））を確認する
[![Image from Gyazo](https://i.gyazo.com/be96546bec04561be6830fdd5c90cbb0.gif)](https://gyazo.com/be96546bec04561be6830fdd5c90cbb0)

## グループ単位でチャットをする
1. Chatページの新規チャットルーム作成ボタンから、チャットしたいユーザーを選択しチャットルームを作成する。
[![Image from Gyazo](https://i.gyazo.com/d80b5461fc8489f442e4a12ad39203c5.gif)](https://gyazo.com/d80b5461fc8489f442e4a12ad39203c5)

## ライドイベントを企画する
1. チャットルームのイベントボタンをクリックし、チャットルームに属するライドイベント一覧を確認する
2. イベント名をクリックしてイベントの詳細を確認する。イベントの参加・不参加をクリックして登録する。
3. 新規イベント作成ボタンから、イベントの内容（イベント名、イベントの詳細、Garmin（サイクリングコース）のURL）を入力し、イベントを作成する。
[![Image from Gyazo](https://i.gyazo.com/9f00e29a6bdf6029d0d2a0a6b700e131.gif)](https://gyazo.com/9f00e29a6bdf6029d0d2a0a6b700e131)
## プロフィール編集
1. 画面右上のユーザー名をクリックして、プロフィール画面を確認する
2. プロフィール編集画面をクリックして、自己紹介文・プロフィール画像を編集する
[![Image from Gyazo](https://i.gyazo.com/a1e2f9712fb2a76efc6282f5335c3d57.gif)](https://gyazo.com/a1e2f9712fb2a76efc6282f5335c3d57)

# アプリケーションを作成した背景
写真共有アプリに投稿された写真を閲覧したときに、撮影場所を知りたくても位置情報が登録されておらず撮影場所が不明なことが多くあった。また、ロードバイクはグループで活動することもあるが、グループでチャットをしながらイベントを管理できる場が無いことから、撮影地情報付きの写真を共有でき、なおかつライドイベントも企画することができるアプリケーションを開発することにした。

# 実装予定の機能
1. ユーザーのフォロー機能
2. グループチャットの参加者編集機能
3. 複数枚画像投稿機能

# データベース設計
![cycleconnect](https://github.com/user-attachments/assets/9d0af6b3-67e6-4237-b236-3e670f415641)

# 画面遷移図
![Screen Transition Diagram](https://github.com/user-attachments/assets/f9b0deb7-042c-49b7-8e1b-bca251a8d857)

# 開発環境
・フロントエンド<br>
・バックエンド<br>
・インフラ<br>
・テスト<br>
・テキストエディタ<br>

# ローカルでの動作方法
以下のコマンドを順に実行。<br>
% git clone https://github.com/asuma3399/cycleconnect.git<br>
% cd cycleconnect<br>
% bundle install<br>

# 工夫したポイント
1. 投稿する写真データに位置情報が含まれていれば、緯度と経度を抜き出して自動的に地図上に表示させるようにした。
2. グループチャット内でのイベント企画機能を作成し、グループ単位でのイベント企画をできるようにした。