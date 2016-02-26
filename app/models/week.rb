class Week
  attr_accessor :start_date

  def initialize(start_date, workouts)
    @start_date = start_date
    @workouts = workouts.group_by(&:box).reduce({}) do |memo, (box, ws)|
      uniq_times = ws.map{ |w| w.datetime.strftime("%H:%M") }.uniq.sort

      by_day = ws.group_by do |w|
        (w.datetime.wday == 0) ? 7 : w.datetime.wday
      end

      doubles_per_day = uniq_times.reduce({}) { |memo, t| memo[t] = 1; memo }

      by_day.each_pair do |k, v|
        v.
          group_by{ |w| 
            w.datetime.strftime("%H:%M") 
          }.
          each_pair{ |t, ws| 
            doubles_per_day[t] = [doubles_per_day[t], ws.size].max
          }
      end      

      by_day.each_pair do |k, v|
        by_day[k] = uniq_times.flat_map do |t| 
          r = v.select{ |w| w.datetime.strftime("%H:%M") == t }
          if r.present?
            ([nil] * (doubles_per_day[t] - r.size)) + r
          else
            [nil] * doubles_per_day[t]
          end
        end
      end

      memo[box] = by_day
      memo
    end
  end

  def workouts_for(box, wday)
    @workouts.fetch(box, {}).fetch(wday, [])
  end

  def end_date
    (start_date + 6.days).to_date
  end
end
