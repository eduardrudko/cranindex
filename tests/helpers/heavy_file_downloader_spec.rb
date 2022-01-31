# frozen_string_literal: true

require_relative '../../helpers/heavy_file_downloader'

RSpec.describe Helpers::HeavyFileDownloader do

  let(:url) { 'http://cran.r-project.org/src/contrib/PACKAGES.gz' }

  after do
    FileUtils.rm_rf('tmp')
  end

  context 'when there is a file on a server' do
    it 'downloads it and saves in tmp/' do
      expect(File.file?(Helpers::HeavyFileDownloader.download(url))).to be true
    end
  end
end