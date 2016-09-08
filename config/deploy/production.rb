set :stage, :production
server '139.59.24.83', user: 'deploy', roles: %w{web app db}
