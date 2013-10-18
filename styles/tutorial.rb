Teacup::Stylesheet.new(:tutorial) do

  style :root,
    backgroundColor: 'white'.to_color

  style :label,
    constraints: [
      constrain(:center_y).equals(:superview, :center_y).minus(150),
      :center_x,
      constrain_width(200),
    ]

  style :doneButton,
    title: 'done',

    constraints: [
      :center_x,
      :bottom,
    ]
end