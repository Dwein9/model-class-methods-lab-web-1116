class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #returns all captains of catamarans
    joins(boats: :classifications).where(classifications: {name: 'Catamaran'})
    # (classifications.name = ?, 'Catamaran')
  end

  def self.sailors
    #returns captains with sailboats
    Captain.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.motorboators
    #returns captains with motorboats
    Captain.joins(boats: :classifications).where(classifications: {name: 'Motorboat'}).distinct
  end

  def self.talented_seamen
    # returns captains of motorboats and sailboats
    where(id: sailors.pluck(:id) & motorboators.pluck(:id))
  end

  #Select * from captains, join on boats, join on classifications, where classifications.name = motorboats and classifications.name = sailboats

  def self.non_sailors
    # returns people who are not captains of sailboats
    where.not(id: sailors.pluck(:id))
  end
end

# Captain has many boats - Captain.joins(:articles)
# category has many articles - Category.joins(:articles)
