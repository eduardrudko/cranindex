# frozen_string_literal: true

require_relative '../../helpers/heavy_file_loader'

RSpec.describe Helpers::HeavyFileUtils do

  let(:url) { 'http://cran.r-project.org/src/contrib/PACKAGES.gz' }

  context 'when there is a file on a server' do
    it 'downloads it and saves in tmp/' do
      expect(File.file?(Helpers::HeavyFileUtils.download(url))).to be true
    end

    it 'unzips tar.gz files and saves decompressed file in tmp/' do
      file = Helpers::HeavyFileUtils.download(url)
      expect(Helpers::HeavyFileUtils.unpack_gz_by_batches(file)).not_to end_with '.gz'
    end
  end

  context "when the server not available"
  xit 'raises an exception'
end