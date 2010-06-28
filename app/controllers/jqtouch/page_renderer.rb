class Jqtouch::PageRenderer < ParagraphRenderer

  paragraph :jqtouch_headers

  def jqtouch_headers
    @options = paragraph_options(:jqtouch_headers)

    require_js('/components/jqtouch/jqtouch/jquery.1.3.2.min.js') if @options.include_jquery
    require_js('/components/jqtouch/jqtouch/jqtouch.min.js')
               
    require_css('/components/jqtouch/jqtouch/jqtouch.min.css')
    require_css("/components/jqtouch/themes/#{@options.theme}/theme.min.css")


    @preload_images = @options.preload_images.reject(&:blank?).map { |img| "'/components/jqtouch/themes/#{img}'" }

    header_js_code = <<-JQTOUCHHEADER 
<script type='text/javascript'>
var jQT = new $.jQTouch({
  #{"icon: '#{@options.icon_url}'," if @options.icon_url}
  #{"startupScreen: '#{@options.startup_url}'," if @options.startup_url}
  statusBar: 'black-translucent',
  formSelector: '.form',
  preloadImages: [
    #{@preload_images.join(",\n")}
  ]
});
    
</script>
JQTOUCHHEADER

    html_include(:extra_head_html,header_js_code)
    
    render_paragraph :nothing => true
  end

end
