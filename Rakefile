# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Voxe.org'
  app.device_family = [:iphone, :ipad]
  app.pods do
    pod 'ViewDeck'
    pod 'MBProgressHUD', '~> 0.6'
    pod 'AFNetworking'
  end
  app.icons = ['AppIcon.png', 'AppIcon@2x.png']
  app.prerendered_icon = true
  app.files += Dir.glob(File.join(app.project_dir, 'styles/**/*.rb'))
end
