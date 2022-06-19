# frozen_string_literal: true

class Callable
  extend Dry::Initializer

  def self.call(...)
    new(...).call
  end

  def call
    raise NotImplementedError, self
  end
end
