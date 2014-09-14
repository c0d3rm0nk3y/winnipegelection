  class CreateIssueWebsites < ActiveRecord::Migration
  def change
    create_table :issues_websites do |t|
      t.string :title
      t.string :description
      t.string :url
      t.references :election

      t.timestamps
    end
  end
end
