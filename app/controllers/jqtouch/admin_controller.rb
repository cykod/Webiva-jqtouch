
class Jqtouch::AdminController < ModuleController

 component_info 'Jqtouch', :description => 'Jqtouch support', 
                              :access => :public
                              
 # Register a handler feature
 register_permission_category :jqtouch, "Jqtouch" ,"Permissions related to Jqtouch"
  
 register_permissions :jqtouch, [ [ :manage, 'Manage Jqtouch', 'Manage Jqtouch' ],
                                  [ :config, 'Configure Jqtouch', 'Configure Jqtouch' ]
                                  ]
 cms_admin_paths "options",
    "Jqtouch Options" => { :action => 'index' },
    "Options" => { :controller => '/options' },
    "Modules" => { :controller => '/modules' }

 permit 'jqtouch_config'

 public 
 
 def options
    cms_page_path ['Options','Modules'],"Jqtouch Options"
    
    @options = self.class.module_options(params[:options])
    
    if request.post? && @options.valid?
      Configuration.set_config_model(@options)
      flash[:notice] = "Updated Jqtouch module options".t 
      redirect_to :controller => '/modules'
      return
    end    
  
  end
  
  def self.module_options(vals=nil)
    Configuration.get_config_model(Options,vals)
  end
  
  class Options < HashModel
   # Options attributes 
   # attributes :attribute_name => value
  
  end
  
end
