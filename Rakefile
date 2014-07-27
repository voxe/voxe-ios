# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
require 'rubygems'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Voxe.org'
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait]
  app.pods do
    pod 'ViewDeck'
    pod 'MBProgressHUD', '~> 0.6'
    pod 'AFNetworking'
  end
  app.icons = ['AppIcon.png', 'AppIcon@2x.png']
  app.prerendered_icon = true
  app.files += Dir.glob(File.join(app.project_dir, 'styles/**/*.rb'))
  # app.testflight.sdk = 'vendor/TestFlight'
  # app.testflight.api_token = ''
  # app.testflight.app_token = ''
  # app.testflight.team_token = ''
end
