# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

exec_list = [
#	:placetypes,
#	:places,
#	:tools,
#	:employee_types,
#	:employees,
	:task_domains,
]
verbose = true

if verbose
	puts "Criando os seguintes modelos:\n\n#{exec_list}"
	puts "\nOk? Interrompa (Ctrl+C) enquanto pode"
	5.times { print '.' ; sleep(0.5) }
end

if exec_list.include? :placetypes
# ======================================================================================================

	# PlaceTypes creation

	placetypes = [
		{title: 'Quarto Base', description: 'Quarto bem básico.', restricted: false, common: false},
		{title: 'Quarto Suíte', description: 'Quarto que também é suíte.', restricted: false, common: false},
		{title: 'Quarto Luxo', description: 'Quarto cheio de luxos.', restricted: false, common: false},
		{title: 'Quarto Master', description: 'Quarto só para quem pode MESMO.', restricted: false, common: false},
		{title: 'Lavanderia', description: 'Lugar para lavar roupas', restricted: true, common: true},
		{title: 'Refeitório', description: 'Lugar para consumo de alimentos', restricted: false, common: true},
		{title: 'Lazer', description: 'Lugar para atividades de lazer', restricted: false, common: true},
		{title: 'Corredor', description: 'Dá acesso a outros lugares', restricted: false, common: true},
		{title: 'Garagem', description: 'Contém vagas para automóveis', restricted: false, common: true},
		{title: 'Cozinha', description: 'Lugar onde se preparam as refeições', restricted: true, common: true}
	]
	puts "TIPOS DE LUGAR:\n#{placetypes}" if verbose

	pts = PlaceType.create!(placetypes)

# ======================================================================================================
end

if exec_list.include? :places
# ======================================================================================================

	# Places creation

	places = []
	pts ||= PlaceType.all
	pts_ = {
		base: pts[0], suite: pts[1], luxo: pts[2],
		mast: pts[3], lav: pts[4], ref: pts[5],
		lazer: pts[6], corr: pts[7], gar: pts[8], coz: pts[9]
	}

	alphabet = ('A'..'F').to_a
	buildings = alphabet.take([2, Random.rand(alphabet.count)].max)

	# Criando os quartos em cada construção
	buildings.each do |letter|

		puts "CONSTRUÇÃO #{letter}" if verbose
		floors = 1 + Random.rand(7)
		rooms_per_floor = [3, Random.rand(18)].max
		washing_machine_rooms_per_floor = Random.rand(1 + (rooms_per_floor * 0.1).ceil)
		corridors_per_floor = 1 + Random.rand(1 + Math.sqrt(rooms_per_floor).ceil)
		puts "#{floors} ANDARES, #{rooms_per_floor} Quartos por andar" if verbose
		
		# Cada construção tem vários andares
		floors.times do |i|

			puts "\t#{i}º ANDAR" if verbose
			pt = if i == floors - 1 # último andar
				Random.rand(10) < 2 ? pts_[:mast] : pts_[:luxo]
			elsif i % 5 == 3 # alguns outros andares podem ser quartos de luxo
				Random.rand(10) < 5 ? pts_[:luxo] : pts_[:suite]
			else
				Random.rand(10) < 3 ? pts_[:suite] : pts_[:base]
			end

			# Cada andar tem vários quartos
			rooms_per_floor.times do |j|
				code = "%s-%03d" % [letter, 100 * i + j]
				compl = case (1 + Random.rand(100))
				when 1..10
					"Bloco #{1 + Random.rand(3)}"
				when 11..15
					"Ala #{alphabet[Random.rand(alphabet.count)]}"
				else
					nil
				end

				puts "\t\t(#{code}) #{compl} #{pt.title}..." if verbose
				places << Place.create!(code: code, compl: compl, place_type_id: pt.id)
			end

			pt = pts_[:lav]
			washing_machine_rooms_per_floor.times do |j|
				code = "%s.L%02d" % [letter, 10 * i + j]
				puts "\t\t(#{code}) #{pt.title}..." if verbose
				places << Place.create!(code: code, place_type_id: pt.id)
			end

			pt = pts_[:corr]
			corridors_per_floor.times do |j|
				code = "|%s.C%02d|" % [letter, 10 * i + j]
				puts "\t\t(#{code}) #{pt.title}..." if verbose
				places << Place.create!(code: code, place_type_id: pt.id)
			end
		end

		pt = pts_[:gar]
		Random.rand(1 + (floors * rooms_per_floor * 0.05).ceil).times do |i|
			code = "%s.G%02d" % [letter, i]
			puts "\t(#{code}) #{pt.title}..." if verbose
			places << Place.create!(code: code, place_type_id: pt.id)
		end

		pt = pts_[:ref]
		Random.rand(1 + (floors * rooms_per_floor * 0.01).ceil).times do |i|
			code = "%s.R%d" % [letter, i]
			puts "\t(#{code}) #{pt.title}..." if verbose
			places << Place.create!(code: code, place_type_id: pt.id)
		end
	end

	# Academias, Bosques, Piscinas, Saunas

	pt = pts_[:lazer]
	(Random.rand(1 + (places.count * 0.03).ceil) % 100).times do |l|
		code = "Acad.%02d" % l
		puts "(#{code}) #{pt.title}..." if verbose
		places << Place.create!(code: code, place_type_id: pt.id)
	end

	(Random.rand(1 + (places.count * 0.015).ceil) % 100).times do |l|
		code = "Bosq.%02d" % l
		puts "(#{code}) #{pt.title}..." if verbose
		places << Place.create!(code: code, place_type_id: pt.id)
	end

	(Random.rand(1 + (places.count * 0.05).ceil) % 100).times do |l|
		code = "Pisc.%02d" % l
		puts "(#{code}) #{pt.title}..." if verbose
		places << Place.create!(code: code, place_type_id: pt.id)
	end

	(Random.rand(1 + (places.count * 0.04).ceil) % 100).times do |l|
		code = "Saun.%02d" % l
		puts "(#{code}) #{pt.title}..." if verbose
		places << Place.create!(code: code, place_type_id: pt.id)
	end

# ======================================================================================================
end

if exec_list.include? :tools
# ======================================================================================================

	# Tools creation

	tools = []
		
		# carrinhos de limpeza
	desc = "Contêiner de equipamentos de limpeza sob rodas. Comprado em 20%02d."
	(Random.rand(1 + (Place.all.count * 0.3).ceil) + 1).times do |i|
		title = "Carrinho de Limpeza #{i + 1}"
		description = desc % Random.rand(16)
		puts "(#{title}) #{description}..." if verbose
		tools << Tool.create!(title: title, description: description)
	end

		# vassouras
	desc = "Instrumento de limpeza. Modelo Nimbus 20%02d."
	(Random.rand(1 + 2 * tools.count) + 1).times do |i|
		title = "Vassoura #{i + 1}"
		description = desc % Random.rand(16)
		puts "(#{title}) #{description}..." if verbose
		tools << Tool.create!(title: title, description: description)
	end

		# escadas
	desc = "Equipamento para alcançar lugares altos, %.02f m de comprimento."
	(Random.rand(1 + tools.count) + 1).times do |i|
		title = "Escada #{i + 1}"
		description = desc % (0.1 * Random.rand(60) + 1)
		puts "(#{title}) #{description}..." if verbose
		tools << Tool.create!(title: title, description: description)
	end

		# caixas de ferramentas
	desc = "Caixa contendo diversas ferramentas para conserto e manutenção em geral."
	(Random.rand(1 + tools.count) + 1).times do |i|
		title = "Caixa de Ferramentas #{i + 1}"
		puts "(#{title}) #{desc}..." if verbose
		tools << Tool.create!(title: title, description: desc)
	end

# ======================================================================================================
end

if exec_list.include? :employee_types
# ======================================================================================================

	# Employee types creation

	employeetypes = [
		{title: 'Camareiro', description: 'Descrição do camareiro'},
		{title: 'Lavadeiro', description: 'Descrição do lavadeiro'},
		{title: 'Faxineiro', description: 'Descrição do faxineiro'},
		{title: 'Assistente', description: 'Descrição do assistente'},
		{title: 'Técnico Geral', description: 'Descrição do TG'},
		{title: 'Técnico Eletricidade', description: 'Descrição do TE'},
		{title: 'Técnico Construção', description: 'Descrição do TC'},
		{title: 'Técnico Hidráulico', description: 'Descrição do TH'},
	]
	
	ets = EmployeeType.create!(employeetypes)
	puts "\n\nTIPOS DE FUNCIONÁRIO:\n#{employeetypes}\n\n" if verbose

		
	
# ======================================================================================================
end

if exec_list.include? :employees
# ======================================================================================================

	# Employees creation

	ets ||= EmployeeType.all
	n_places = Place.all.count
	alphabet = ('a'..'z').to_a

	employees = []
	ntotal = (1.5 * n_places + Random.rand(0.75 * n_places)).ceil
	percents = [0.35, 0.20, 0.20, 0.10, 0.05, 0.05, 0.05, 0.05]
	percents.each_index do |i|

		et_id = ets[i].id
		et_t = ets[i].title
		puts "(#{et_t})"
		(100 * percents[i] / percents.sum).ceil.times do |j|
			str = et_t[0]
			str += et_t[8] if et_t =~ /Técnico/
			str.downcase!
			e = {
				name: "#{j} #{et_t}",
				last_name: alphabet.shuffle.join[0..(3 + Random.rand(8))].capitalize,
				cpf: "%03d.%03d.%03d-%02d" % [Random.rand(1000), Random.rand(1000), Random.rand(1000), Random.rand(100)],
				birth: Date.today - 18.years - Random.rand(37 * 365).days,
				email: "#{str}#{j}@coopel.com.br",
				password: "senha123",
				employee_type_id: et_id
			}
			puts "\t#{e}"
			Employee.create!(e)
		end
	end		
	
# ======================================================================================================
end

if exec_list.include? :task_domains
# ======================================================================================================

	# Task Domains creation

	task_domains = [
		{title: 'Limpeza', description: 'Serviços relacionados à limpeza, higiene de locais.'},
		{title: 'Resíduos', description: 'Serviços relacionados ao manuseio do lixo.'},
		{title: 'Infraestrutura', description: 'Serviços relacionados à manutenção da infraestrutura.'},
		{title: 'Hóspede', description: 'Serviços relacionados ao atendimento do hóspede.'},
		{title: 'Roupas', description: 'Serviços relacionados à lavagem de roupas (cama, mesa e banho).'},
		{title: 'Jardinagem', description: 'Serviços relacionados à manutenção de áreas verdes.'},
		{title: 'Eletrônicos', description: 'Serviços relacionados à manutenção de equipamentos eletrônicos.'},
		{title: 'Encanamento', description: 'Serviços relacionados à manutenção de encanamentos.'}
	]
	tds = TaskDomain.create!(task_domains)
	puts "\n\nDOMÍNIOS DE TAREFA:\n#{task_domains}\n\n" if verbose

	
# ======================================================================================================
end

