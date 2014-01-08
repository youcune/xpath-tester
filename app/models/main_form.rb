require 'active_model'

class MainForm
  include ActiveModel::Model

  attr_accessor :xpath, :xml

  validates :xpath, presence: true
  validates :xml, presence: true, length: { maximum: 1024*100 }

  def ==(form)
    self.xpath == form.xpath && self.xml == form.xml
  end
end
