# -*- mode: crystal -*-
require "./Population"

class GeneticAlgorithm
  getter populationSize
  getter mutationRate
  getter crossoverRate
  getter elitismCount
  
  def initialize(@populationSize : Int32, @mutationRate : Float32, @crossoverRate : Float32, @elitismCount : Int16)
  end

  def initPopulation(chromosomeLength : Int32)
    population = Population.new(@populationSize, chromosomeLength)
    return population
  end

  def calcFitness(individual)
    correctGenes = 0
    
    individual.chromosome.each do |chromosome|
      if chromosome == 1
        correctGenes += 1
      end
    end

    fitness = (correctGenes.to_f / individual.chromosome.size).as(Float64)
    individual.fitness = fitness

    return fitness
  end

  def evalPopulation(population)
    populationFitness = 0.0

    population.individuals.each do |individual|
      populationFitness += calcFitness(individual)
    end

    population.fitness = populationFitness
  end

  def selectParent(population)
    individuals = population.individuals

    populationFitness = population.fitness
    rouletteWheelPosition = Random.rand * populationFitness

    # find parent
    spinWheel = 0.0
    individuals.each do |individual|
      spinWheel += individual.fitness
      if (spinWheel > rouletteWheelPosition)
        return individual
      end
    end

    return individuals[population.size - 1]
  end
  
  def crossoverPopulation(population)
    newPopulation = Population.new(population.size)

    population.individuals.each_with_index do |individual, populationIndex|
      parent1 = population.fittest(populationIndex)

      if @crossoverRate > Random.rand && populationIndex > @elitismCount
        offspring = Individual.new(parent1.chromosome.size)

        #find second parent
        parent2 = selectParent(population)

        # loop over genome
        parent1.chromosome.each_with_index do |chromosome, index|
          # use half of parent1's genes and half of parent2's genes
          if (0.5 > Random.rand)
            offspring.setGene(index, parent1.getGene(index))
          else
            offspring.setGene(index, parent2.getGene(index))
          end
        end

        # add offstring to population
        newPopulation.setIndividual(populationIndex, offspring)
      else
        # add inidividual to new population without appliying crossover
        newPopulation.setIndividual(populationIndex, parent1)
      end
    end
    
    return newPopulation
  end

  def mutatePopulation(population)
    newPopulation = Population.new(population.size)

    population.individuals.each_with_index do |individual, populationIndex|
      newIndividual = population.fittest(populationIndex)

      newIndividual.chromosome.each_with_index do |gene, geneIndex|
        if (populationIndex >= @elitismCount)
          if @mutationRate > Random.rand
            newGene : Int8 = 1
            if (newIndividual.getGene(geneIndex) == 1)
              newGene = 0
            end

            newIndividual.setGene(geneIndex, newGene)
          end
        end
      end

      newPopulation.setIndividual(populationIndex, newIndividual)
    end
    return newPopulation
  end
  
  def isTerminationConditionMet(population)
    population.individuals.each do |individual|
      if (individual.fitness == 1)
        return true
      end
    end

    return false
  end
end
