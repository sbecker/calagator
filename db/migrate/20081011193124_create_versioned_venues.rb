class CreateVersionedVenues < ActiveRecord::Migration
  def self.up
    Venue.create_versioned_table do |t|
      t.string   "title"
      t.text     "description"
      t.string   "address"
      t.string   "url"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "street_address"
      t.string   "locality"
      t.string   "region"
      t.string   "postal_code"
      t.string   "country"
      t.decimal  "latitude"
      t.decimal  "longitude"
      t.string   "email"
      t.string   "telephone"
      t.integer  "source_id"
      t.integer  "duplicate_of_id"
      t.integer  "version"
    end
  end

  def self.down
    Venue.drop_versioned_table
  end
end
