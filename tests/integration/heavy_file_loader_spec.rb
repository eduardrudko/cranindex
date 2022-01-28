# frozen_string_literal: true

require_relative '../../helpers/heavy_file_loader'

RSpec.describe Helpers::HeavyFileLoader do

  let(:path) { "/tmp/PACKAGES.gz" }
  let(:url) { 'http://cran.r-project.org/src/contrib/PACKAGES.gz' }

  after do
    FileUtils.rm_rf(path)
  end

  context 'when downloading large files' do
    it 'it downloads it and saves in /tmp' do
      Helpers::HeavyFileLoader.new(path, url).download_file
      expect(File.exist?(path)).to be true
    end
  end
end