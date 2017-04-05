require 'serverspec'
require 'docker'

describe 'Dockerfile' do

  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :backend, :docker
    set :docker_image, image.id
  end

  describe command('cat /config/aria2.conf') do
    its(:stdout) { is_expected.to include 'rpc-listen-all=true' }
    its(:stdout) { is_expected.to include 'rpc-secure=true' }
    its(:stdout) { is_expected.to include 'rpc-certificate=/config/cert/server.crt' }
    its(:stdout) { is_expected.to include 'rpc-private-key=/config/cert/server.key' }
  end

  describe x509_certificate('/config/cert/server.crt') do
    it { is_expected.to be_certificate }
    its(:validity_in_days) { is_expected.to be > 364 }
    its(:keylength) { is_expected.to be >= 2048 }
  end

  describe x509_private_key('/config/cert/server.key') do
    it { is_expected.not_to be_encrypted }
    it { is_expected.to be_valid }
    it { is_expected.to have_matching_certificate '/config/cert/server.crt' }
  end

  describe command("aria2c http://ipv4.download.thinkbroadband.com/5MB.zip" +
                   "  --checksum=md5=b3215c06647bc550406a9c8ccc378756") do
    its(:stdout) { is_expected.to include 'download completed' }
    its(:stderr) { is_expected.to be_empty }
  end

end
