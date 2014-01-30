require 'rexml/document'

class MainController < ApplicationController
  def index
    if request.get?
      @form = MainForm.new
    else
      @form = MainForm.new(main_params)
      if @form.valid?
        begin
          pretty = REXML::Formatters::Pretty.new
          pretty.compact = true

          document = REXML::Document.new(@form.xml)

          if @form.current_node.nil?
            current_node = document
          else
            current_node = document.get_elements(@form.current_node)
            if current_node.size > 1
              flash.now[:info] = 'More than one elements have matched Current Node. I hope it\'s ok!'
            end
          end

          @elements = REXML::XPath.match(current_node, @form.xpath).map do |e|
            if e.kind_of?(REXML::Element)
              str = StringIO.new
              pretty.write(e, str)
              str.string
            else
              e.to_s
            end
          end
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
