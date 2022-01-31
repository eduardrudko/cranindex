# frozen_string_literal: true

require_relative '../../helpers/heavy_file_utils'

RSpec.describe Helpers::HeavyFileUtils do

  let(:url) { 'http://cran.r-project.org/src/contrib/PACKAGES.gz' }
  let(:package_url) { 'http://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz' }

  after do
    FileUtils.rm_rf('tmp')
  end

  context 'when there is a file on a server' do
    it 'downloads it and saves in tmp/' do
      expect(File.file?(Helpers::HeavyFileUtils.download(url))).to be true
    end

    it 'unzips gz files and saves decompressed file in tmp/' do
      file = Helpers::HeavyFileUtils.download(url)
      expect(Helpers::HeavyFileUtils.unpack_gz_by_batches(file)).not_to end_with '.gz'
    end

    it 'unpacks tar.gz file and saves it in tmp/' do
      tar_gz = Helpers::HeavyFileUtils.download(package_url)
      Helpers::HeavyFileUtils.unpack_tar_gz(tar_gz)
      expect(File.directory?("tmp/A3")).to be true
    end
  end

  context "when the server is not available"
  xit 'raises an exception and clean ups'
end