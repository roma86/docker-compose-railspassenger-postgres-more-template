module LogHelper

  require 'colorize'

  @LOG_PREFIX = 'APP: '
  LINE = '-' * 20

  def log_g(message, append_line = false, file_path=nil)
    log message.green, append_line, file_path=nil
  end
  module_function :log_g

  def log_r(message, append_line = false, file_path=nil)
    log message.red, append_line, file_path=nil
  end
  module_function :log_r

  def log_y(message, append_line = false, file_path=nil)
    log message.yellow, append_line, file_path=nil
  end
  module_function :log_y

  def log_b(message, append_line = false, file_path=nil)
    log message.blue, append_line, file_path=nil
  end
  module_function :log_b

  def log(message, append_line = false, file_path=nil)
    File.open(file_path, 'a') { |file| file << message } unless file_path == nil
    Rails.logger.debug(@LOG_PREFIX+ message)
    Rails.logger.debug(@LOG_PREFIX+ LINE) if append_line
  end
  module_function :log

end
