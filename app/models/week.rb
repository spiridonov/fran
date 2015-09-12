class Week

  attr_accessor :start_date

  def initialize(start_date, workouts)
    @start_date = start_date
    @workouts = workouts.group_by(&:box).reduce({}) do |memo, (box, ws)|
      memo[box] = ws.group_by do |w|
        (w.datetime.wday == 0) ? 7 : w.datetime.wday
      end
      memo
    end
  end

  def workouts_for(box, wday)
    @workouts.fetch(box, {}).fetch(wday, []).sort_by{ |w| w.datetime }
  end

  def end_date
    (start_date + 6.days).to_date
  end

end