# autoload files, when initialization
Dir.glob(File.join("#{ChunChen::Application.config.root}/lib/autoload", "**", "*.rb")) do |file|
  require "#{file}"
end
