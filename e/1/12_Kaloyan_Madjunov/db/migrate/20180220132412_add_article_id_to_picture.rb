class AddArticleIdToPicture < ActiveRecord::Migration[5.1]
  def change
  	add_column :pictures, :article_id, :integer 
  end
end
