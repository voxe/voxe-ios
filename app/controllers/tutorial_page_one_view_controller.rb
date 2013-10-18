class TutorialPageOneVC < UIViewController
  attr_accessor :index

  stylesheet :tutorial
  layout :root do
    @label = subview(UILabel, :label, text: 'page one')
  end

  def index
    0
  end

  def viewDidLoad
    super
    self.view.backgroundColor = 'white'.to_color
    # customize label
    @label.font = UIFont.fontWithName("Helvetica", size:12)
    @label.lineBreakMode = UILineBreakModeWordWrap
    @label.numberOfLines = 0
    @label.textAlignment = UITextAlignmentCenter
  end

end