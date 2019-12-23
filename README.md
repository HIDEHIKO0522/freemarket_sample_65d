# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|name_kana|string|null: false|
|nickname|string|null: false|
|sex|integer|null: false|
|birthday|integer|null: false|
|email|string|null: false|
|password|string|null: false|
|tel|integer|null: false|
|identification|string|null: false|
|image|string|null: false|
|point|integer|
|sales|integer|
|to_do|integer|
|certification|string|null: false|
### Association
- has_many :likes
- has_many: evaluations
- has_many: items
- has_many: dms
- has_many: commnets
- has_many: sns_credentials
- has_one :address


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|type|integer|null: false|
### Association
- belongs_to :user, optional: true


## cardテーブル
|Column|Type|Options|
|------|----|-------|
|type|integer|null: false|
|number|string|null: false|
|city|string|null: false|
|security_code|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|expiration_date|string|null: false|
### Association
- belongs_to :user, optional: true



## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item



## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|comment|text|null: false|
|category_id|integer|null: false, foreign_key: true|
|condition|integer|null: false|
|brand|integer|null: false|
|complete_day|integer|null: false|
|seller_id|integer|null: false, foreign_key: true|
|buyer_id|integer|null: false, foreign_key: true|
|size|integer|null: false|
|price|integer|null: false|
|arrival_date|integer|null: false|
|charge|integer|null: false|
|location|string|null: false|
|status|integer|null: false|
|delivery|integer|null: false|
### Association
- belongs_to:user
- has_many :likes
- has_many:dms
- has_many:item_images
- has_many:item_comments
- belongs_to :category


## item_commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|comment|text|null: false|
### Association
- belongs_to:user
- belongs_to:item


## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|image|string|null: false|
### Association
- belongs_to:item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|
### Association
- has_many :items
- has_ancestry





## dmsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|comment|text|null: false|
### Association
- belongs_to:user
- belongs_to:item


## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|judge|integer|null: false|
|comment|text|
|seller_id|integer|null: false, foreign_key: true|
|buyer_id|integer|null: false, foreign_key: true|
### Association
- belongs_to:user


## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string|null: false|
|provider|string|null: false|
|token|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user