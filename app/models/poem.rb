class Poem < ActiveRecord::Base
  belongs_to :author

  def author_name
    self.author.name
  end

end
