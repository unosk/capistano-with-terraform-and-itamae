node.validate! do
  {
    app: {
      environment: string,
      deploy_to: string,
      deploy_as: string,
      deploy_id_rsa: string
    }
  }
end

# Railsアプリに依存関係のあるネイティブパッケージのインストール
%w(
  build-essential
  zlib1g-dev
  libssl-dev
  libmysqlclient-dev
  imagemagick
  libmagickwand-dev
  nodejs
).each do |pkg|
  package pkg
end

# デプロイディレクトリ
directory node[:app][:deploy_to] do
  owner node[:app][:deploy_as]
  group node[:app][:deploy_as]
end

# デプロイ鍵の設置
user node[:app][:deploy_as] do
  create_home true
end

file "/home/#{node[:app][:deploy_as]}/.ssh/id_rsa" do
  owner node[:app][:deploy_as]
  group node[:app][:deploy_as]
  content node[:app][:deploy_id_rsa]
end

file "/home/#{node[:app][:deploy_as]}/.ssh/config" do
  owner node[:app][:deploy_as]
  group node[:app][:deploy_as]
  content "Host bitbucket.org\n  StrictHostKeyChecking no"
end
