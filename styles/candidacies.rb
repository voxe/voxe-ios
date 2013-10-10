Teacup::Stylesheet.new :candidacies do
  style :root,
    backgroundColor: 'white'.to_color

  style :table,
    constraints: [
      :topleft, :full_height,
      constrain(:width).equals(:superview, :width).minus(44),
    ]
end