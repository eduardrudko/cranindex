# frozen_string_literal: true

class RootApp < BaseApp
  get '/' do
    'Hello world!'
  end
end