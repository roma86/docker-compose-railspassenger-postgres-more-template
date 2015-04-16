ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
module Minitest
  module Reporters
    class AwesomeReporter < BaseReporter
      require 'ruby-progressbar'
      include RelativePosition
      include ANSI::Code

      PROGRESS_MARK = '='

      def initialize(options = {})
        super
        @detailed_skip = options.fetch(:detailed_skip, true)

        @progress = ProgressBar.create({
           total:          total_count,
           starting_at:    count,
           progress_mark:  green(PROGRESS_MARK),
           remainder_mark: ' ',
           format:         '  %C/%c: [%B] %p%% %a, %e',
           autostart:      false
        })
      end

      def start
        super
        puts('Started with run options %s' % options[:args])
        puts
        @progress.start
        @progress.total = total_count
        show
      end

      def record(test)
        super
        return if test.skipped? && !@detailed_skip
        if test.failure
          print "\e[0m\e[1000D\e[K"
          print_colored_status(test)
          print_test_with_time(test)
          puts
          print_info(test.failure, test.error?)
          puts
        end

        if test.skipped? && color != "red"
          self.color = "yellow"
        elsif test.failure
          self.color = "red"
        end

        show
      end

      def report
        super
        @progress.finish

        puts
        puts('Finished in %.5fs' % total_time)
        print('%d tests, %d assertions, ' % [count, assertions])
        if failures == 0 && errors == 0
          print(green { '%d failures, %d errors, ' } % [failures, errors])
        else
          print(red { '%d failures, %d errors, ' } % [failures, errors])
        end
        print(yellow { '%d skips' } % skips)
        puts
      end

      private

      def show
        @progress.increment unless count == 0
      end

      def print_test_with_time(test)
        puts [test.name, test.class, total_time].inspect
        print(" %s#%s (%.2fs)" % [test.name, test.class, total_time])
      end

      def color
        @color ||= "green"
      end

      def color=(color)
        @color = color
        @progress.progress_mark = send(color, PROGRESS_MARK)
      end
    end
  end
end

Minitest::Reporters.use!(
    Minitest::Reporters::AwesomeReporter.new(:color => true)
)
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
