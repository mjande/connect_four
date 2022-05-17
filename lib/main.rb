# frozen_string_literal: true

require_relative 'game'

game = Game.new
game.start_game

# Weird bug where checking at the margins does not work 
# Happens for the right edge, but not left
# Top edge not yet tested
# Look into this more tomorrow