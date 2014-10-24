maintainer       'gogojimmy'
maintainer_email 'jimmy@commandp.me'
license          'MIT'
description      'Configure and deploy sidekiq on opsworks.'

name   'sidekiq'
recipe 'sidekiq::default', 'Set up sidekiq and start worker'
recipe 'sidekiq::restart', 'Restart sidekiq worker'
recipe 'sidekiq::stop',    'Stop sidekiq worker'
