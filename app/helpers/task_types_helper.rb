module TaskTypesHelper

  def readable_weekdays wds
    return if wds.nil?
    indexes = wds.split("").map { |wd| wd.to_i }
    arr = []

    all_wds = "Dom|Seg|Ter|Qua|Qui|Sex|Sáb".split("|")
    all_wds.each_index do |i|
      arr << all_wds[i] if indexes.include? i
    end
    arr.join(", ")
  end

  def readable_time minutes_offset
    return if minutes_offset.nil? || !minutes_offset.is_a?(Numeric)
    t = DateTime.now.beginning_of_day + minutes_offset.minutes
    t.strftime("%H:%M")
  end

end
