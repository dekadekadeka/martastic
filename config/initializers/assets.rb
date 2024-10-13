# Generate non-digest versions as well
Rails.application.config.assets.prefix = "/assets"
Rails.application.config.assets.precompile += %w( application.js application.css )
