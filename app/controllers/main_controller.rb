require 'rexml/document'

class MainController < ApplicationController
  def index
    if request.get?
      @form = MainForm.new
    else
      @form = MainForm.new(main_params)
      if @form.valid?
        begin
          document = REXML::Document.new(@form.xml)
          current_node = @form.current_node.nil? ? document : document.get_elements(@form.current_node)
          @elements = REXML::XPath.match(current_node, @form.xpath)
        rescue REXML::ParseException => e
          flash.now[:danger] = "<h4>XML Parse Error</h4>#{safen(e.continued_exception.to_s)}"
        end
      else
        flash.now[:danger] = @form.errors.full_messages.join('<br>')
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def main_params
    params.require(:main_form).permit(:xpath, :current_node, :xml)
  end

  def safen(str)
    str.gsub(/</, '&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;').gsub(/\n/, '<br>')
  end
end
