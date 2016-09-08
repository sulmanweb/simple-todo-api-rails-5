set :stage, :production
server '52.90.241.25', user: 'deploy', roles: %w{web app db}
