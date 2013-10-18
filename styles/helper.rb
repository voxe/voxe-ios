Teacup::Stylesheet.new(:helper) do

  style :root,
    backgroundColor: 'white'.to_color

  style :label,
    constraints: [
      constrain(:center_y).equals(:superview, :center_y).minus(200),
      :center_x,
      constrain_width(200),
    ]

  style :button,
    title: 'neat.',
    constraints: [
      :center_x,
      constrain_below(:label).plus(0),
    ]
end