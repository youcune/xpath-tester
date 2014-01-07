XPathTester::Application.routes.draw do
  root to: 'main#index', via: [:get, :post]
end
