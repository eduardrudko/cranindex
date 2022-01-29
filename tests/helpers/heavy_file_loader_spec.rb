# frozen_string_literal: true

require_relative '../../helpers/heavy_file_loader'

RSpec.describe Helpers::HeavyFileLoader do

  let(:path) { "PACKAGES.gz" }
  let(:url) { 'http://cran.r-project.org/src/contrib/PACKAGES.gz' }

  context 'when there is a file on a server' do
    it 'downloads it and saves in tmp/' do
      file = Helpers::HeavyFileLoader.new(path, url).download
      expect(File.file?(file)).to be true
    end

    it 'unzips tar.gz files and saves decompressed file in tmp/' do
      loader = Helpers::HeavyFileLoader.new(path, url)
      file = loader.download
      expect(loader.ungzip(file)).not_to end_with '.gz'
    end
  end

  context "when the server not available"
  xit 'raises an exception'
end