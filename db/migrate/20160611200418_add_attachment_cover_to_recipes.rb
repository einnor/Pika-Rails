class AddAttachmentCoverToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :recipes, :cover
  end
end
