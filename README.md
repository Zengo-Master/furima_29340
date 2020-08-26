# テーブル設計

## users テーブル

| Column           | Type    | Options     |
| ---------------- | ------  | ----------- |
| nickname         | string  | null: false |
| email            | string  | null: false |
| password         | string  | null: false |

### Association

- has_one  :profile
- has_many :items
- has_many :purchases

## profiles テーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| family_name      | string     | null: false |
| first_name       | string     | null: false |
| family_name_kana | string     | null: false |
| first_name_kana  | string     | null: false |
| birth_year       | integer    | null: false |
| birth_month      | integer    | null: false |
| birth_day        | integer    | null: false |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## items テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| name                | string     | null: false |
| description         | text       | null: false |
| category            | integer    | null: false |
| status              | integer    | null: false |
| shipping_fee_burden | integer    | null: false |
| shipping_prefecture | integer    | null: false |
| shipping_days       | integer    | null: false |
| price               | integer    | null: false |
| stock               | boolean    | null: false |
| user                | references | null: false, foreign_key: true|

### Association

- belongs_to :user
- has_one    :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs to :item
- has_one    :shipping_address

## shipping_addresses テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| buyer_postal_code   | string     | null: false |
| buyer_prefecture    | integer    | null: false |
| buyer_city          | string     | null: false |
| buyer_home_number   | string     | null: false |
| buyer_building_name | string     |             |
| buyer_phone_number  | integer    | null: false |
| purchase            | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase