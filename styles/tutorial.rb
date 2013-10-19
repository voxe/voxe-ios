Teacup::Stylesheet.new(:tutorial) do

  style :root,
    backgroundColor: 'white'.to_color

  style :pagecontrol,
    constraints: [
      constrain_height(100),
      :full_width,
      :bottom,
    ]

  style :abovePageControl,
  constraints: [
    constrain_width(250),
    constrain_above(:pagecontrol).minus(15),
    :center_x,
  ]

  style :logo,
    constraints: [
      constrain(:center_y).equals(:superview, :center_y).minus(100),
      :center_x,
      constrain_width(100),
      constrain_height(100),
    ]

  style :aboveLogo,
  constraints: [
    constrain_width(250),
    constrain_above(:logo).minus(15),
    :center_x,
  ]

  style :belowLogo,
  constraints: [
    constrain_width(250),
    constrain_below(:logo).plus(25),
    :center_x,
  ]

  style :centeredImage,
  constraints: [
    :center_x,
    constrain(:center_y).equals(:superview, :center_y).minus(75),
    constrain_width(175),
  ]

  style :closeToTop,
  constraints: [
    :center_x,
    constrain_width(250),
    constrain(:top).equals(:superview, :top).plus(40),
#    constrain_above(:centeredImage).minus(50),
  ]

  style :belowCenteredImage,
  constraints: [
    constrain_width(250),
    constrain_below(:centeredImage).plus(25),
    :center_x,
  ]

  style :label,
    landscape: {
      constraints: [
      :center_y,
      :center_x,
      constrain_width(200),
      ],
    },
    portrait: {
      constraints: [
        constrain(:center_y).equals(:superview, :center_y).minus(50),
        :center_x,
        constrain_width(200),
      ]
    }

  style :doneButton,
    title: 'Terminer',
    constraints: [
      :center_x,
#      constrain(:bottom).equals(:superview, :bottom).minus(75),
      constrain_below(:belowCenteredImage).plus(25),
    ]

end