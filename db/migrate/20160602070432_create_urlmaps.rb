class CreateUrlmaps < ActiveRecord::Migration
  def change
    create_table :urlmaps do |t|
      t.string :short_url
      t.string :long_url

      t.timestamps null: false
    end
  end
end
