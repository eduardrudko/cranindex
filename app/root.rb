# frozen_string_literal: true

class RootApp < BaseApp

  get '/' do
    # TODO: API for retrieving URL by name
  end

  get '/packages' do
    if params[:dependencies]
      package = Repositories::PackageRepository.get_packages_based_on(:dependencies, params)
      json resonse: {
        data: package
      }
    end
  end
end