# -*- encoding: utf-8 -*-

require 'spec_helper'

describe MainForm do
  it 'はXPathとXMLの両方がある場合に検証を通る' do
    form = MainForm.new(xpath: '/element', xml: '<element>value</element>')
    expect(form).to be_valid
  end

  it 'はXPathがない場合にバリデーションエラーとする' do
    form = MainForm.new(xpath: '', xml: '<element>value</element>')
    expect(form).to be_invalid
  end

  it 'はXMLがない場合にバリデーションエラーとする' do
    form = MainForm.new(xpath: '/element', xml: '')
    expect(form).to be_invalid
  end

  it 'はXMLが1024*100文字まで許容する' do
    form = MainForm.new(xpath: '/element', xml: '<element>value</element>' * 4266)
    expect(form).to be_valid
  end

  it 'はXMLが長すぎる場合にバリデーションエラーとする' do
    form = MainForm.new(xpath: '/element', xml: '<element>value</element>' * 4267)
    expect(form).to be_invalid
  end
end
