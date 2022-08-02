# frozen_string_literal: true

module Reports
  class TimeReports
    extend Dry::Initializer

    param :token
    option :page, default: proc { 1 }, reader: :private
    option :entries, default: proc { [] }, reader: :private
    option :queries, default: proc { {} }, reader: :private
    option :from_date, default: proc { 1.month.ago.to_date }
    option :to_date, default: proc { Date.today }

    def entries
      return @entries if @entries.present?

      loop do
        @entries += query['time_entries'].map { Entry.new(_1, token.user) }
        break if query['page'] == query['total_pages']

        @page = query['page'] + 1
      end
      entries
    end

    def count_hours
      data = entries.each_with_object({}) do |entry, output|
        output[entry.task] ||= 0
        output[entry.task] += entry.hours
      end

      data.transform_values { _1.round(2) }.map { |title, hours| { name: title, hours: hours } }
    end

    private

    def query # rubocop:disable Metrics/AbcSize
      return @queries[page] if page.in?(@queries.keys)

      response = Query.call(token, page, from_date: from_date, to_date: to_date)
      raise JSON.parse(response.body) unless response.status == 200

      @queries[page] = JSON.parse(response.body)
    end
  end
end
