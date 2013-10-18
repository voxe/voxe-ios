class TutorialPageThreeVC < UIViewController
  attr_accessor :index

  stylesheet :tutorial
  layout :root do
    @label = subview(UILabel, :label, text: 'page three')
    @doneButton = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :doneButton)
  end

  def index
    2
  end

  def viewDidLoad
    super
    self.view.backgroundColor = 'white'.to_color
    # customize label
    @label.font = UIFont.fontWithName("Helvetica", size:12)
    @label.lineBreakMode = UILineBreakModeWordWrap
    @label.numberOfLines = 0
    @label.textAlignment = UITextAlignmentCenter
    # set up done button
    @doneButton.addTarget(self, action:'donePressed', forControlEvents:UIControlEventTouchUpInside)
  end

  def donePressed
    p 'done with tutorial'
  end

end