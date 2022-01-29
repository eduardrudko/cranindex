# frozen_string_literal: true

class CreatePackages < ActiveRecord::Migration[4.2]
  def up
    create_table :packages do |table|
      table.string :name, index: true
      table.string :version
      table.string :r_version_needed
      table.string :dependencies
      table.string :date_of_publication
      table.string :title
      table.string :authors
      table.string :maintainers
      table.string :license
      table.string :url
    end
  end

  def down
    drop_table :packages
  end
end