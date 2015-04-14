module ApplicationHelper

	def self.menu_items
		[:employees, :employee_types, :places, :place_types, :responsibilities, :task_domains, :task_types, :tasks, :tools, :services]
	end

  def cool_date dt
    unless dt.nil?
      l(dt).downcase
    end
  end

  def cool_date_interval dt1, dt2
    unless dt1.nil? || dt2.nil?
      str = (l dt1) << " - "
      if dt1.day != dt2.day
        str << (l dt2)
      else
        str << (l dt2, format: :short)
      end
    end
  end

  def show_checkmark bool
    return "" if bool.nil?
    icon = bool ? 'check-circle text-success' : 'minus text-danger'
    ("<i class=\"fa fa-#{icon} text-success\"></i> " << (bool ? 'Sim' : 'Não')).html_safe
  end

end
