# frozen_string_literal: true

module TimeHelper
  def seconds_to_hms(sec)
    hours = sec / 3600
    minutes = sec / 60 % 60
    seconds = sec % 60
    format('%<hours>02d:%<minutes>02d:%<seconds>02d', hours: hours, minutes: minutes, seconds: seconds)
  end
end
