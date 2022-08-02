# frozen_string_literal: true

module Reports
  class Entry
    def initialize(data, user)
      @data = data
      @user = user
    end

    def project
      @project ||= @data.dig('project', 'name')
    end

    def hours
      @hours ||= @data['hours']
    end

    def task_name
      @task_name ||= @data.dig('task', 'name')
    end

    def notes
      @notes ||= @data['notes']
    end

    def task
      @task ||= @user.category_by_title(task_name).gsub('<<PROJECT>>', project)
    end
  end
end
