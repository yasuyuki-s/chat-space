# DB設計
## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true, unique: true|
|mail|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :messages
- has_many :groups, through: :members
- has_many :members

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true, unique: true|

### Association
- has_many :messages
- has_many :users, through: :group_users
- accepts_nested_attributes_for :group_users
- has_many :gruop_users


## membersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user
