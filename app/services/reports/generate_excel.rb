# frozen_string_literal: true

module Reports
  class GenerateExcel < Callable
    MONTH_NAMES = %w[Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień].freeze

    param :data
    param :user
    param :start_date, default: proc { Time.now }

    def call
      update_header
      update_body

      file = Tempfile.new("#{Time.now.to_i}.xls")
      begin
        template_workbook.write file.path
        data = File.read(file.path)

        FileStringIO.new(output_file_name, data)
      ensure
        file.close!
      end
    end

    private

    def update_header
      update_row(0, 0, '<<DATE>>', Time.parse(user.agreement_date).strftime('%Y-%m-%d'))
      update_row(4, 3, '<<NAME>>', user.company_name)
      update_row(5, 3, '<<MONTH>>', month)
      update_row(6, 3, '<<YEAR>>', year)
    end

    def update_body
      start = 9
      finish = 19

      (finish - start).times do |index|
        row = index + start
        service = data.to_a[index]
        update_service_row(service, row, index)
      end

      total_hours = data.inject(0) { |out, s| out + s[:hours] }.round(2)
      update_row(finish, 4, '<<SUM>>', total_hours)
    end

    def update_service_row(service, row, index)
      if service
        update_row(row, 0, '<<LP>>', index + 1)
        update_row(row, 1, '<<SERVICE>>', service[:name])
        update_row(row, 4, '<<HOURS>>', service[:hours])
      else
        worksheet.row(row).hidden = true
      end
    end

    def update_row(row, col, template, value)
      worksheet[row, col] = worksheet[row, col].gsub(template, value.to_s)
    end

    def output_workbook
      @output_workbook ||= Spreadsheet::Workbook.new
    end

    def worksheet
      @worksheet ||= template_workbook.worksheets[0]
    end

    def template_workbook
      @template_workbook ||= Spreadsheet.open(Rails.root.join('app/lib/evidence.xls'))
    end

    def output_file_name
      [month, ' - ', year, '.xls'].join
    end

    def month
      MONTH_NAMES[start_date.month - 1]
    end

    def year
      start_date.year
    end
  end
end
