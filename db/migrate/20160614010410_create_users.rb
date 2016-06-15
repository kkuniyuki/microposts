class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address #住所
      t.string :location #地域      

      t.timestamps null: false
      
      t.index :email, unique: true # メールアドレスユニーク
    end
  end
end
