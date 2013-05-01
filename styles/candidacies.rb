Teacup::Stylesheet.new :candidacies do
  style :root

  style :table,
    constraints: [
      :topleft, :full_height,
      constrain(:width).equals(:superview, :width).minus(44),
    ]
end
