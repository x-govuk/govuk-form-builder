# :nocov:
module Rails
  def self.logger
    Logger.new($stdout)
  end
end
# :nocov:
