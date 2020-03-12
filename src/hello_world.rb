require_relative 'game_entities/game_entity'
Dir[File.join(__dir__, 'game_entities', '*.rb')].each { |entity| require_relative entity.chomp('.rb') }
Dir[File.join(__dir__, 'clients', '*.rb')].each { |client| require_relative client.chomp('.rb') }
