class RemoveOldStyleFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :old_style
  end
end
