module TaskTypesHelper

  def week_day_labels
    ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"]
  end

  # "0123456" => "Dom, Seg, Ter, Qua, Qui, Sex, Sáb"
  def readable_weekdays wds
    return if wds.nil?
    indexes = wds.split("").map { |wd| wd.to_i }
    arr = []

    all_wds = week_day_labels
    all_wds.each_index do |i|
      arr << all_wds[i] if indexes.include? i
    end
    arr.join(", ")
  end

  # 615 => 10:15
  def readable_time minutes_offset
    return if minutes_offset.nil? || !minutes_offset.is_a?(Numeric)
    t = DateTime.now.beginning_of_day + minutes_offset.minutes
    t.strftime("%H:%M")
  end

  # ["1", "5", "6"] => "156"
  # [true, false, false, false, false, false, true] => "06" # (previously)
  def parse_checkmarks arr_checks
    arr_checks.join("")
    # "0123456".split("").select { |ch| arr_checks[ch.to_i] }.join("")
  end

  def parse_hours_and_minutes hour, min
    hour.to_i * 60 + min.to_i
  end

  def parse_form_periodic_params ttparams
    hsh = {}
    return hsh if ttparams["week_days"].nil?
    hsh["week_days"] = parse_checkmarks ttparams["week_days"]
    hsh["after_in_minutes"] = parse_hours_and_minutes(ptt["after_in_minutes(4i)"], ptt["after_in_minutes(5i)"])
    hsh["before_in_minutes"] = parse_hours_and_minutes(ptt["before_in_minutes(4i)"], ptt["before_in_minutes(5i)"])
    hsh
  end

end
