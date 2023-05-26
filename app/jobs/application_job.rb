class ApplicationJob < ActiveJob::Base
  include Resque::Kubernetes::Job
  queue_as :default
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  def job_manifest
    YAML.safe_load(
      <<~MANIFEST
        apiVersion: batch/v1
        kind: Job
        metadata:
          name: worker-job
        spec:
          template:
            metadata:
              name: worker-job
            spec:
              containers:
              - name: worker
                image: us.gcr.io/project-id/some-resque-worker
                env:
                - name: QUEUE
                  value: high-memory
      MANIFEST
    )
  end
end
