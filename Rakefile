require './app'

namespace :assets do
    desc 'compile assets'
    task :compile => [:compile_js, :compile_css] do
    end

    desc 'compile javascript assets'
    task :compile_js do
        sprockets = App.sprockets
        sprockets.js_compressor = Uglifier.new
        asset = sprockets['application.js']
        outpath = File.join(App.assets_path, 'js')
        outfile = Pathname.new(outpath).join('application.js') # may want to use the digest in the future?

        FileUtils.mkdir_p outfile.dirname

        asset.write_to(outfile)

        puts "successfully compiled js assets"
    end

    desc 'compile css assets'
    task :compile_css do
        sprockets = App.settings.sprockets
        sprockets.css_compressor = :sass
        asset = sprockets['application.css']
        outpath = File.join(App.settings.assets_path, 'css')
        outfile = Pathname.new(outpath).join('application.css')

        FileUtils.mkdir_p outfile.dirname

        asset.write_to(outfile)

        puts "successfully compiled css assets"
    end
    # todo: add :clean_all, :clean_css, :clean_js tasks, invoke before writing new file(s)
end
