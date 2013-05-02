Teacup::Stylesheet.new :tags do
  style :root,
    backgroundColor: 'white'.to_color

  style :table,
    constraints: [
      :topright, :full_height,
      constrain(:width).equals(:superview, :width).minus(44),
    ]
end