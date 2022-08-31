class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, limit: 30, null: false #p133 文字列カラムの長さを制限するlimitオプションとNOT NULL制約。
      t.text :description

      t.timestamps
    end
  end
end
