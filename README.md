# README

## 概要

AnimalGraphyは、あなたの好みにあった動物の写真を自由に投稿、閲覧できるサービスです。

ディープラーニングによって、投稿された写真から動物が検出され、自動的にタグがつきます。

## 機能

* ログイン・ログアウト機能

* 写真・コメント投稿機能

* 投稿編集機能

* 投稿削除機能

## 環境

* 言語 : Ruby 2.7.1

* WEBフレームワーク : Ruby on Rails 5.2.4.2

* テスト環境 : Minitest 5.14.0

* 学習済みモデル : YOLOv3

* 推論エンジン : ONNX Runtime

* データベース : MySQL 5.7

* 実行・開発環境 : Docker

* 運用環境 : AWS EC2

## 実行方法

起動

`docker-compose up`

停止

`docker-compose down`

データベースの作成

`docker-compose run web rails db:create`
`docker-compose run web rails db:migrate`

※学習済みモデルとラベルファイルをダウンロードし、public/object_detectionディレクトリ内に配置

ダウンロード : https://github.com/onnx/models/tree/master/vision/object_detection_segmentation/yolov3
