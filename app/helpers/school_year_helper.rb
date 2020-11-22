module SchoolYearHelper
  def school_year_at(date = Time.zone.now)
    (date - 3.months).year
  end
end
