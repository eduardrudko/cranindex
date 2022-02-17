# frozen_string_literal: true

class AddIndexToAuthorsAndMaintainers < ActiveRecord::Migration[4.2]
  def up
    add_index :packages, :authors
    add_index :packages, :maintainers
  end

  def down
    remove_index :package, :authors
    remove_index :packages, :authors
  end
end