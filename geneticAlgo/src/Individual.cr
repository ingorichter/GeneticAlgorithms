# -*- mode: crystal -*-
class Individual
  getter chromosome
  property fitness : Float64
  
  def initialize(chromosomeLength : Int32)
    @chromosome = Array(Int8).new
    @fitness = -1.0
    
    chromosomeLength.times do
      if (0.5 < Random.rand)
        @chromosome << 1
      else
        @chromosome << 0
      end
    end
  end

  def getGene(index)
    @chromosome[index]
  end

  def setGene(index, value)
    @chromosome[index] = value
  end
  
  def <=>(individual)
    self.fitness <=> individual.fitness
  end

  def <(individual)
    self.fitness < individual.fitness
  end

  def <=(individual)
    self.fitness <= individual.fitness
  end
 
  def to_s(io)
    io << "Individual: "
    @chromosome.each do |chromosome|
      io << chromosome
    end
  end
end
