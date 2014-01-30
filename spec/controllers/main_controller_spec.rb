# -*- encoding: utf-8 -*-

require 'spec_helper'

describe MainController do

  describe 'GET index' do
    it 'はGETでリクエストすると空の@formを渡す' do
      get :index
      expected = MainForm.new
      actual = assigns(:form)
      expect(actual).to eq expected
    end
  end

  describe 'POST index' do
    it 'はPOSTでリクエストすると渡されたパラメータで@formを構築する' do
      post :index, { main_form: { xpath: '/element', current_node: '', xml: '<element>value</element>' } }
      expected = MainForm.new(xpath: '/element', current_node: '', xml: '<element>value</element>')
      actual = assigns(:form)
      expect(actual).to eq expected
    end

    it 'はCurrent Nodeに複数マッチする場合、そのことを教えてあげる' do
      post :index, { main_form: { xpath: '', current_node: '//a', xml: '<root><a>A1</a><a>A2</a></root>' } }
      expect(flash[:info]).to be_present
    end

    it 'は空のパラメータで呼ばれた場合、エラーをflashにセットする' do
      post :index, { main_form: { xpath: '', current_node: '', xml: '' } }
      expect(flash[:danger]).to be_present
    end

    it 'は不正なXMLで呼ばれた場合、エラーをflashにセットする' do
      post :index, { main_form: { xpath: '/element', current_node: '', xml: '<element1>value</element2>' } }
      expect(flash[:danger]).to include 'XML Parse Error'
    end

    it 'はXPath関数を受け付ける' do
      post :index, { main_form: { xpath: 'count(element)', current_node: '', xml: '<element>value</element>' } }
      expect(assigns(:elements)).to eq ['1']
    end
  end
end
