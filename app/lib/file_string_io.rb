# frozen_string_literal: true

class FileStringIO < StringIO
  def initialize(*args)
    super(*args[1..])
    @filename = args[0]
  end

  def original_filename
    File.basename(@filename)
  end
end
