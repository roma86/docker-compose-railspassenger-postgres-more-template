class TestJob < ActiveJob::Base
  require 'log_helper'

  queue_as :default

  def perform(*args)
    LogHelper.log_g "TestJob work", true
  end
end
