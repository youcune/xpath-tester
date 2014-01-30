require 'active_model'

class MainForm
  include ActiveModel::Model

  attr_accessor :xpath, :current_node, :xml

  validates :xml, presence: true, length: { maximum: 1024*100 }

  def ==(form)
    self.xpath == form.xpath && self.current_node == form.current_node && self.xml == form.xml
  end
end
