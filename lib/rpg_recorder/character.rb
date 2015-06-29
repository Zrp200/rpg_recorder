module RPGRecorder
	class Character
		attr_accessor :health, equipment
		def dead?
			@health <= -1
		end
		def unconscious?
			@health <= 0 && not dead?
		end
		def initialize(health = 1, equipment = {})
			@health, @equipment = health, equipment
		end
		def defend(base_damage, shield = nil) # Lessens damage taken at expense of armor durability
			equipment.each_pair do |name, item|
				if item.is_kind_of? Armor && !item.broken?
					blocked_damage = abs(base_damage - item.durability)
					item.durability -=  base_damage
					puts "#{name} broke!" if item.broken?
					base_damage -= blocked_damage
					break if base_damage <= 0
				end
			end
			return "No damage recieved!" if base_damage <= 0
			@health -= base_damage
		end

	end
end
