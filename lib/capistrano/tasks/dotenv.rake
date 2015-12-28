namespace :dotenv do
  desc 'Upload .env'
  task :upload do
    on roles(:app, :worker) do
      dotenv = fetch(:dotenv)
      upload! StringIO.new(dotenv), release_path.join('.env')
    end
  end
end
