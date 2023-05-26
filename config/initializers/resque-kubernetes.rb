Resque::Kubernetes.configuration do |config|
 config.enabled     = Rails.env.production?
 config.max_workers = 5
end