class Employee < ActiveRecord::Base
	belongs_to :employee_type
	has_many :tasks

	def fullname
		self.name + " " + self.last_name
	end

	def masked_cpf
		masked_cpf = self.cpf.match(/(\d{3})(\d{3})(\d{3})(\d{2})/)
		masked_cpf[1] + "." + masked_cpf[2] + "." + masked_cpf[3] + "-" + masked_cpf[4]
	end

end
