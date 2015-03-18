# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
pts = PlaceType.create!(placetypes)
ptis = {
	base: pts[0].id, suite: pts[1].id, luxo: pts[2].id,
	mast: pts[3].id, lav: pts[4].id, ref: pts[5].id,
	lazer: pts[6].id, corr: pts[7].id, gar: pts[8].id, coz: pts[9].id
}
# ======================================================================================================

	# Places creation

places = []

alphabet = ('A'..'Z').to_a
buildings = alphabet.take([2, Random.rand(alphabet.count)].max)

	# Criando os quartos em cada construção
buildings.each do |letter|

	puts "CONSTRUÇÃO #{letter}"
	floors = 1 + Random.rand(10)
	rooms_per_floor = [3, Random.rand(100)].max
	washing_machine_rooms_per_floor = Random.rand(1 + (rooms_per_floor * 0.1).ceil)
	corridors_per_floor = 1 + Random.rand(1 + Math.sqrt(rooms_per_floor).ceil)
	puts "#{floors} ANDARES, #{rooms_per_floor} Quartos por andar"
	
	# Cada construção tem vários andares
	floors.times do |i|

		puts "\t#{i}º ANDAR"
		placetype_id = if i == floors - 1 # último andar
			Random.rand(10) < 2 ? ptis[:mast] : ptis[:luxo]
		elsif i % 5 == 3 # alguns outros andares podem ser quartos de luxo
			Random.rand(10) < 5 ? ptis[:luxo] : ptis[:suite]
		else
			Random.rand(10) < 3 ? ptis[:suite] : ptis[:base]
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

			puts "\t\tQuarto (#{code}) #{compl}..."
			places << Place.create!(code: code, compl: compl, placetype_id: placetype_id)
		end

		washing_machine_rooms_per_floor.times do |j| # 1..10
			code = "%s.L%02d" % [letter, 10 * i + (j - 1)]
			places << Place.create!(code: code, placetype_id: ptis[:lav])
		end

		corridors_per_floor.times do |j|
			code = "|%s.C%02d|" % [letter, 10 * i + (j - 1)]
			places << Place.create!(code: code, placetype_id: ptis[:corr])
		end
	end

	Random.rand(1 + (floors * rooms_per_floor * 0.05).ceil).times do |i|
		code = "%s.G%02d" % [letter, i]
		places << Place.create!(code: code, placetype_id: ptis[:gar])
	end

	Random.rand(1 + (floors * rooms_per_floor * 0.01).ceil).times do |i|
		code = "%s.R%d" % [letter, i]
		places << Place.create!(code: code, placetype_id: ptis[:ref])
	end
end

	# Academias, Bosques, Piscinas, Saunas

(Random.rand(1 + (places.count * 0.01).ceil) % 100).times do |l|
	code = "Acad.%02d" % l
	places << Place.create!(code: code, placetype_id: ptis[:lazer])
end

(Random.rand(1 + (places.count * 0.008).ceil) % 100).times do |l|
	code = "Bosq.%02d" % l
	places << Place.create!(code: code, placetype_id: ptis[:lazer])
end

(Random.rand(1 + (places.count * 0.01).ceil) % 100).times do |l|
	code = "Pisc.%02d" % l
	places << Place.create!(code: code, placetype_id: ptis[:lazer])
end

(Random.rand(1 + (places.count * 0.005).ceil) % 100).times do |l|
	code = "Saun.%02d" % l
	places << Place.create!(code: code, placetype_id: ptis[:lazer])
end

# ======================================================================================================
