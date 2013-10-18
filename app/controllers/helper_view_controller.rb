class HelperViewController < UIViewController
  attr_accessor :delegate, :spinner

  stylesheet :helper
  layout :root do
    @label = subview(UILabel, :label, text: 'Appuyez sur le bouton ci-dessus pour commencer')
    #@button = subview(UIButton.rounded, :button)
  end

  def viewDidLoad
    super
    # hide back button
    self.navigationItem.hidesBackButton = true
    # customize label
    @label.font = UIFont.fontWithName("Helvetica", size:12)
    @label.lineBreakMode = UILineBreakModeWordWrap
    @label.numberOfLines = 0
    @label.textAlignment = UITextAlignmentCenter
    # set button on navigation bar
    @logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
    @logoButton.frame = [[0,0],[32,32]]
    @logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
    @logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    navigationItem.titleView = @logoButton
  end

  def logoButtonPressed
    self.delegate.helperViewControllerDismissed
  end

  def spinner
    if @spinner.nil?
      @spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
      @spinner.hidesWhenStopped = true
      navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(@spinner)
    end
    @spinner
  end

end