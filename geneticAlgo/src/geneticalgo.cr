# -*- mode: crystal -*-
# TODO: Write documentation for `Geneticalgo`
require "./GeneticAlgorithm"

module Geneticalgo
  VERSION = "0.1.0"

  geneticAlgo = GeneticAlgorithm.new 200, 0.01, 0.95, 0
  population = geneticAlgo.initPopulation(10)

  geneticAlgo.evalPopulation(population)
  generation = 1

  while (!geneticAlgo.isTerminationConditionMet(population))
    puts "Best solution #{population.fittest(0)}"

    population = geneticAlgo.crossoverPopulation(population)

    population = geneticAlgo.mutatePopulation(population)

    geneticAlgo.evalPopulation(population)
    
    generation += 1
  end

  puts "Found solution in #{generation} generations"
  puts "Best solution: #{population.fittest(0)}"
end
