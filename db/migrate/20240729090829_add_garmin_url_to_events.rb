class AddGarminUrlToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :garmin_url, :string
  end
end
