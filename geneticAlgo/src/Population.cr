# -*- mode: crystal -*-
require "./Individual"

class Population
  property fitness : Float64
  getter population
  
  def initialize(populationSize : Int32, chromosomeLength : Int32 = 0)
    @population = Array(Individual).new
    @fitness = 0

    if chromosomeLength
      populationSize.times do
        @population << Individual.new chromosomeLength
      end
    end
  end

  def individuals
    @population
  end

  def size
    return @population.size
  end

  def setIndividual(index, individual)
    @population[index] = individual
  end
  
  def fittest(offset)
    sortedPopulation = @population.sort_by{ |individual| individual.fitness }.reverse
    return sortedPopulation[offset]
  end
  
  def to_s(io)
    io << "Population with size #{@population.size}"
    @population.each do |individual|
      io << individual
    end
  end
end
