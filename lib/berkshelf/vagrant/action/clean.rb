module Berkshelf
  module Vagrant
    module Action
      # @author Jamie Winsor <jamie@vialstudios.com>
      class Clean
        attr_reader :shelf

        def initialize(app, env)
          @app = app
          @shelf = Berkshelf::Vagrant.shelf_for(env)
        end

        def call(env)
          if Berkshelf::Vagrant.chef_solo?(env[:vm].config) && self.shelf
            Berkshelf.formatter.msg "cleaning Vagrant's shelf"
            FileUtils.remove_dir(self.shelf, fore: true)
          end

          @app.call(env)
        end
      end
    end
  end
end
