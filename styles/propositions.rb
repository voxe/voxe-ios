Teacup::Stylesheet.new :propositions do
  style :root,
    backgroundColor: '#E7ECEE'.to_color

  style :webView,
    constraints: [
      :full_width,
      :full_height,
      constrain_top(0)
    ]

end
