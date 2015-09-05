# Checkpoint #40 - Topics and Posts
#
#   rails g model topic name:string public:boolean description:text
class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      
      # Checkpoint #40 - Topics and Posts
      #
      # Set the 'public' attribute to 'true' by default.
      t.boolean :public
      
      t.text :description

      t.timestamps null: false
    end
  end
end
