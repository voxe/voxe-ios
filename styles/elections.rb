Teacup::Stylesheet.new :elections do
  style :root,
    backgroundColor: 'white'.to_color

    style :webview,
    constraints: [
      :topleft,
      :full_width,
      :full_height,
    ]
end
