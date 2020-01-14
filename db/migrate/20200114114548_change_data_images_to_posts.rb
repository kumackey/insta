class ChangeDataImagesToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :post, :images, :json
  end
end
