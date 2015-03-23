class Employee < RedShellModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :employee_type
  has_many :tasks

	def fullname
		self.name + " " + self.last_name
	end

	def masked_cpf
		masked_cpf = self.cpf.match(/(\d{3})(\d{3})(\d{3})(\d{2})/)
		masked_cpf[1] + "." + masked_cpf[2] + "." + masked_cpf[3] + "-" + masked_cpf[4]
	end

	def self.label(field = nil)
		case field
		when nil
			'Funcionário'
		when :name
			'Nome'
		when :last_name
			'Sobrenome'
		when :cpf
			'CPF'
		when :rg
			'RG'
		when :birth
			'Nascimento'
		when :email
			'Email'
		when :password
			'Senha'
		when :password_confirmation
			'Confirmação de senha'
		else
			superclass.label field
		end
	end

	def self.icon
		'user'
	end
end
