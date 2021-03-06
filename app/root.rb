# frozen_string_literal: true

#1. What packages need import the package "htmltools"?
# Constrains
# In what order should the output be?
#
#2. What is the list of emails of authors or maintainers?
# Constrains
# What is the output should be?
# Should it be two lists based on authors and maintainers respectfully or merged list of both?
# Should the output contain mapping between authors/maintainers or just an array of emails?
# Should list contain only distinct emails?
#
#3. Who is the person that has contributed on more packages?
#
class RootApp < BaseApp

  get '/' do
    # TODO: API for retrieving URL by name
  end

  get '/packages' do
    package = Repositories::PackageRepository.packages_based_on(:dependencies, params)
    json response: {
      data: package
    }
  end

  get '/packages/contributor' do
    contributor = Repositories::PackageRepository.contributor
    if contributor
      json response: {
        data: contributor
      }
    else
      status 404
      json response: {
        error: 'No contributors found'
      }
    end
  end

  get '/packages/emails' do
    emails = Repositories::PackageRepository.uniq_emails
    json response: {
      data: emails
    }
  end
end