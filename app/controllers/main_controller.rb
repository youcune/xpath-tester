require 'rexml/document'

class MainController < ApplicationController
  def index
    if request.get?
      @form = MainForm.new
    else
      @form = MainForm.new(main_params)
      if @form.valid?
        begin
          @elements = REXML::Document.new(@form.xml).get_elements(@form.xpath)
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
    params.require(:main_form).permit(:xpath, :xml)
  end

  def safen(str)
    str.gsub(/</, '&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;').gsub(/\n/, '<br>')
  end
end
