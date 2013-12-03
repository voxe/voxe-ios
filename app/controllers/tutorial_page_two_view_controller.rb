class TutorialPageTwoVC < UIViewController
  attr_accessor :index, :delegate

  stylesheet :tutorial
  layout :root do
    @image = subview(UIImageView, :centeredImage, image:UIImage.imageNamed('candidaciesExample.png'))
    @label = subview(UILabel, :closeToTop, text: 'Candidats')
    @label2 = subview(UILabel, :belowCenteredImage, text: 'Glissez l\'écran sur la gauche
pour accéder au choix des candidats')
  end

  def index
    1
  end

  def viewWillAppear(animated)
    super
    self.delegate.changePageControlToCurrentPage(self.index)
  end

  def viewDidLoad
    super
    self.view.backgroundColor = 'white'.to_color
    # customize labels
    @label.font = UIFont.fontWithName("Helvetica", size:20)
    @label.textAlignment = UITextAlignmentCenter
    @label2.font = UIFont.fontWithName("Helvetica", size:14)
    @label2.lineBreakMode = UILineBreakModeWordWrap
    @label2.numberOfLines = 0
    @label2.textAlignment = UITextAlignmentCenter
    # customize image
    @image.contentMode = UIViewContentModeScaleAspectFit
  end

end