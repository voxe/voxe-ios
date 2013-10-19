class TutorialPageOneVC < UIViewController
  attr_accessor :index, :delegate

  # Voxe.org - comparateur neutre et international de programmes politiques

  stylesheet :tutorial
  layout :root do
    @closeToTop = subview(UILabel, :closeToTop, text: 'Voxe.org')
    @belowLogo = subview(UILabel, :belowLogo, text: 'Voxe est un comparateur neutre
et international
de programmes politiques.')
    @logoImageView = subview(UIImageView, :logo, image:UIImage.imageNamed('voxelogobig.png'))
  end

  def index
    0
  end

  def viewWillAppear(animated)
    super
    self.delegate.changePageControlToCurrentPage(self.index)
  end

  def viewDidLoad
    super
    self.view.backgroundColor = 'white'.to_color

    @closeToTop.font = UIFont.fontWithName("Helvetica", size:20)
    @closeToTop.textAlignment = UITextAlignmentCenter

    @belowLogo.font = UIFont.fontWithName("Helvetica", size:14)
    @belowLogo.lineBreakMode = UILineBreakModeWordWrap
    @belowLogo.numberOfLines = 0
    @belowLogo.textAlignment = UITextAlignmentCenter
    
  end

end