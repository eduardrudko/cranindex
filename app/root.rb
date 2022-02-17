# frozen_string_literal: true

class RootApp < BaseApp

  get '/' do
    # TODO: API for retrieving URL by name
  end

  get '/packages' do
    if params[:dependencies]
      package = Repositories::PackageRepository.packages_based_on(:dependencies, params)
      json response: {
        data: package
      }
    end
  end

  get '/packages/emails' do
    emails = Repositories::PackageRepository.list_of_emails
    json response: {
      data: emails
    }
  end
end