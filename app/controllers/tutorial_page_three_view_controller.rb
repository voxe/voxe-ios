class TutorialPageThreeVC < UIViewController
  attr_accessor :index, :delegate

  stylesheet :tutorial
  layout :root do
    @image = subview(UIImageView, :centeredImage, image:UIImage.imageNamed('tagsExample.png'))
    @label = subview(UILabel, :closeToTop, text: 'Thèmes')
    @label2 = subview(UILabel, :belowCenteredImage, text: 'Glissez l\'écran sur la droite
pour choisir un thème de campagne')
    @doneButton = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :doneButton)
  end

  def index
    2
  end

  def viewWillAppear(animated)
    super
    self.delegate.changePageControlToCurrentPage(self.index)
  end

  def viewDidLoad
    super
    self.view.backgroundColor = 'white'.to_color
    # customize label
    @label.font = UIFont.fontWithName("Helvetica", size:20)
    @label.textAlignment = UITextAlignmentCenter
    @label2.font = UIFont.fontWithName("Helvetica", size:14)
    @label2.lineBreakMode = UILineBreakModeWordWrap
    @label2.numberOfLines = 0
    @label2.textAlignment = UITextAlignmentCenter
    # customize image
    @image.contentMode = UIViewContentModeScaleAspectFit
    # set up done button
    @doneButton.addTarget(self, action:'donePressed', forControlEvents:UIControlEventTouchUpInside)
  end

  def donePressed
    self.delegate.navigationController.popToRootViewControllerAnimated(true)
  end

end