class WorkoutForm < Workout

  attr_accessor :hours, :mins, :date

  def self.build(params)
    form = self.new
    form.date = Date.parse(params[:date])
    form.box = Box.find(params[:box_id])
    form.cap = form.box.default_cap
    form
  end

end