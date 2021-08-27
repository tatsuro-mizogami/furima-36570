# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | --------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

has_many :items
has_many :orders

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | -------------------------------|
| item_name          | string     | null: false                    |
| explanation        | text       | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| shipping_burden_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| days_ship_id       | integer    | null: false                    |

belongs_to :user
has_one :order

## addresses テーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| postcode              | string      | null: false                    |
| prefecture.id         | integer     | null: false                    |
| city                  | string      | null: false                    |
| block                 | string      | null: false                    |
| building              | string      |                                |
| tel_number            | string      | null: false                    |
| order                 | string      | null: false, foreign_key: true |

belongs to :order

## orders
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

has_one :address
has_one :item
has_one :user
