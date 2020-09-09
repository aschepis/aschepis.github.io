###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

###### Middleware
# use(Class.new do
#   def initialize(app, options={})
#     @app  = app
#     @path = options[:path] || ::File.expand_path('../', $0)
#   end

#   def call(env)
#     status, headers, body = @app.call(env)

#     if headers['Content-Type'].to_s.include?('text/plain')
#       headers['Content-Type'] = 'text/html'
#     end

#     [status, headers, body]
#   end
# end)
######

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :directory_indexes
activate :blog do |blog|
end
activate :deploy do |deploy|
  deploy.build_before = true # default: false
  deploy.method = :git
  deploy.branch = 'master'
end


ready do
  sitemap.resources.each do |page|
    if page.path =~ /[0-9]{4}-[0-9]{2}-[0-9]{2}-.*/
      proxy "/blog#{page.url}", "/blog/redirect.html", layout: false, locals: {page: page}, ignore: true
      proxy "/blog#{page.url}.html", "/blog/redirect.html", layout: false, locals: {page: page}, ignore: true
      proxy "/raw-content#{page.url}", page.path, layout: false, locals: {current_article: page}
    end
  end
end

page "/sitemap.xml", :layout => false

sprockets.append_path File.join root, 'bower_components'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
