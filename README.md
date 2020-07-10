# README

## 概要

AnimalGraphyは、あなたの好みにあった動物の写真を自由に投稿、閲覧できるサービスです。

ディープラーニングによって、投稿された写真から動物が検出され、自動的にタグがつきます。

## 機能

* ログイン・ログアウト機能

* 写真・コメント・リプライ投稿機能

* いいね機能

* 投稿編集・削除機能

* ニュース・近くの動物園表示機能

## 環境

* 言語 : Ruby 2.7.1

* WEBフレームワーク : Ruby on Rails 5.2.4.3

* テスト環境 : Rspec 4.0.1

* 静的解析ツール : RuboCop 0.85.1

* 学習済みモデル : YOLOv3

* 推論エンジン : ONNX Runtime

* データベース : MySQL 5.7

* 実行・開発環境 : Docker, Docker Compose

* 運用環境 : AWS(EC2, VPC, ELB, Route53, Certificate Manager, IAM)

## 実行方法

### 事前準備

学習済みモデルをダウンロードし、public/object_detectionディレクトリ内に配置

ダウンロード(ミラー) : https://drive.google.com/file/d/1hvfZgLUiykk-v2JaA2oma8U4mZb7NZG1/view?usp=sharing

ダウンロード(公式) : https://github.com/onnx/models/tree/master/vision/object_detection_segmentation/yolov3

※公式サイトからダウンロードする場合ファイル名をyolov3.onnxに変更する必要があるため、ミラーサイトからのダウンロードを推奨

.env_sampleファイルの名前を.envに変更し、適宜環境変数を設定

### 起動

`docker-compose up -d`

### 停止

`docker-compose down`

### ビルド

`docker-compose build`

### データベースの作成

`docker-compose run web rails db:create`

`docker-compose run web rails db:migrate`

`docker-compose run web rails db:seed`
