require "thor"
require "erb"
require "fileutils"

class Configure < Thor
 
  # ...
  def self.exit_on_failure?
    true
  end 
  
  class << self
    def options(options={})
      
      options.each do |option_name, option_settings|
        option option_name, option_settings  
      end
  
    end
  end
  
  module ERBRenderer
    
    def render_from(template_path)
      ERB.new(File.read(template_path), 0, '<>').result binding
    end
    
  end  
  
  class YARNResourceManagerConfiguration
    include ERBRenderer
    
  end
  

  desc "resourcemanager", "Configure the YARN Resource Manager"
  def resourcemanager
    
    configuration = YARNResourceManagerConfiguration.new
    
    File.write '/etc/supervisor/conf.d/resourcemanager.conf',
      configuration.render_from('/etc/supervisor/conf.d/resourcemanager.conf.erb')
    
  end
  
end

Configure.start(ARGV)