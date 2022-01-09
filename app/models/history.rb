# frozen_string_literal: true

class History < ApplicationRecord
  belongs_to :user

  def entries=(entries)
    self.data = entries.values.each_with_object([]) do |entry, obj|
      entry['hours'] = entry['hours'].to_f
      obj << entry
    end
  end
end
