set :stage, :production
server 'todo.sulmanbaig.com', user: 'deploy', roles: %w{web app db}
