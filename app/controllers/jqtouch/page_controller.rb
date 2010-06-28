class Jqtouch::PageController < ParagraphController

  editor_header 'JQTouch Paragraphs'
  
  editor_for :jqtouch_headers, :name => "JQTouch Headers"

  class JqtouchHeadersOptions < HashModel
     attributes :theme => 'apple', :include_jquery => true, :preload_images => [], :icon_id => nil, :startup_id => nil

     domain_file_options :icon_id, :startup_id

     has_options :theme, [['Apple theme','apple'],['JQTouch Theme','jqt']]


     options_form fld(:theme,:select,:options => :theme_select_options),
                  fld(:include_jquery, :yes_no,:label => 'Include jquery.js'),
                  fld(:icon_id,:filemanager_image, :label => 'Add to homepage icon',:description => '57x57 icon'),
                  fld(:startup_id,:filemanager_image,:label => 'Startup Image',:description => '320x460 startup image'),
                  fld(:preload_images,:check_boxes, :options => :preload_image_options,:separator => "<br/>")


     def preload_image_options
        Dir.glob('public/components/jqtouch/themes/*/img/*').map { |img| img.gsub("public/components/jqtouch/themes/","") }
       
     end

  end
end
