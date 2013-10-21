class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds

    @electionViewController = ElectionViewController.alloc.init
    @window.rootViewController = @electionViewController.deckViewController
    application.setStatusBarStyle(UIStatusBarStyleDefault)

    @window.makeKeyAndVisible

    pageControl = UIPageControl.appearance
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor
    pageControl.currentPageIndicatorTintColor = UIColor.blackColor
    pageControl.backgroundColor = UIColor.clearColor

    true
  end
end
