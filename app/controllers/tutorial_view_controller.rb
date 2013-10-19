class TutorialViewController < UIViewController
  attr_accessor :delegate, :spinner, :pageController

  stylesheet :tutorial
  layout :root do
    @pageControl = subview(UIPageControl, :pagecontrol, numberOfPages:3, currentPage:0)
    #@label = subview(UILabel, :label, text: 'Appuyez sur le bouton ci-dessus pour commencer')
  end

  # UIViewController lifecycle

  def viewDidLoad
    super
    # hide navigation bar
    self.navigationController.navigationBarHidden = true

    # set button on navigation bar
    @logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
    @logoButton.frame = [[0,0],[32,32]]
    @logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
    @logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    navigationItem.titleView = @logoButton

    # set page view controller
    @pageController = UIPageViewController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal, options:nil)
    @pageController.dataSource = self
    @pageController.view.frame = self.view.bounds
    @pageController.view.backgroundColor = 'white'.to_color
    @pageController.setViewControllers([self.tutorialViewControllers[0]], direction:UIPageViewControllerNavigationDirectionForward, animated:false, completion:nil)
    #self.addChildViewController(@pageController)
    self.view.addSubview(@pageController.view)
    @pageController.didMoveToParentViewController(self)

    self.view.addSubview(@pageControl)

  end

  # Interface

  def logoButtonPressed
    self.delegate.tutorialViewControllerDismissed
  end

  def spinner
    if @spinner.nil?
      @spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
      @spinner.hidesWhenStopped = true
      navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(@spinner)
    end
    @spinner
  end

  # UIPageController delegate

  def tutorialViewControllers
    if @tutorialViewControllers.nil?
      page1 = TutorialPageOneVC.alloc.init
      page1.delegate = self
      page2 = TutorialPageTwoVC.alloc.init
      page2.delegate = self
      page3 = TutorialPageThreeVC.alloc.init
      page3.delegate = self
      @tutorialViewControllers = [page1, page2, page3]
    end
    @tutorialViewControllers
  end

  def pageViewController(pageViewController, viewControllerBeforeViewController:viewController)
    if viewController.index == 0
      return nil
    end
    self.tutorialViewControllers[viewController.index-1]
  end

  def pageViewController(pageViewController, viewControllerAfterViewController:viewController)
    if viewController.index == 2
      return nil
    end
    self.tutorialViewControllers[viewController.index+1]
  end

  def changePageControlToCurrentPage(index)
    @pageControl.currentPage = index
  end

end