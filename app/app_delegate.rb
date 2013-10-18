class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds

    @electionViewController = ElectionViewController.alloc.init
    @window.rootViewController = @electionViewController.deckViewController
    application.setStatusBarStyle(UIStatusBarStyleBlackOpaque)

    @window.makeKeyAndVisible

    pageControl = UIPageControl.appearance
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor
    pageControl.currentPageIndicatorTintColor = UIColor.blackColor
    pageControl.backgroundColor = UIColor.whiteColor

    true
  end
end
