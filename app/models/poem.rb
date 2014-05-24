class Poem < ActiveRecord::Base
  belongs_to :author

  def author_name
    self.author.name
  end

  validates :title, presence: true
  validates :content, presence: true

end
