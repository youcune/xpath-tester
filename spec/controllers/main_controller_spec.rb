# -*- encoding: utf-8 -*-

require 'spec_helper'

describe MainController do

  describe 'GET index' do
    it 'はGETでリクエストすると空の@formを渡す' do
      get :index
      expected = MainForm.new
      actual = assigns(:form)
      expect(actual).to eq(expected)
    end
  end

  describe 'POST index' do
    it 'はPOSTでリクエストすると渡されたパラメータで@formを構築する' do
      post :index, { main_form: { xpath: '/element', xml: '<element>value</element>' } }
      expected = MainForm.new(xpath: '/element', xml: '<element>value</element>')
      actual = assigns(:form)
      expect(actual).to eq(expected)
    end

    it 'は空のパラメータで呼ばれた場合、エラーをflashにセットする' do
      post :index, { main_form: { xpath: '', xml: '' } }
      expected = MainForm.new(xpath: '', xml: '')
      actual = assigns(:form)
      expect(actual).to eq(expected)
      expect(flash[:danger]).to be_present
    end

    it 'は不正なXMLで呼ばれた場合、エラーをflashにセットする' do
      post :index, { main_form: { xpath: '/element', xml: '<element1>value</element2>' } }
      expected = MainForm.new(xpath: '/element', xml: '<element1>value</element2>')
      actual = assigns(:form)
      expect(actual).to eq(expected)
      expect(flash[:danger]).to include 'XML Parse Error'
    end
  end
end
