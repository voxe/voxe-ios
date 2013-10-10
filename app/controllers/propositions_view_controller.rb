class PropositionsViewController < UIViewController
  attr_accessor :selectedTag, :selectedCandidacies
  BASEURL_WEBVIEW = 'http://voxe.org/webviews/comparisons?electionId=4ef479f8bc60fb0004000001&tagId='

  def viewDidLoad
    view.backgroundColor = '#E7ECEE'.to_color

    # Set logo on navigation bar
    logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
    logoButton.frame = [[0,0],[32,32]]
    logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
    logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    navigationItem.titleView = logoButton

    # Set webview
    @webView = layout(UIWebView, :webView)
    @webView.delegate = self
    self.view = @webView

    # Set toolbar with back button
    navigationController.setToolbarHidden(false, animated:false)
    backItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(101, target:@webView, action:'goBack')
    backItem.style = UIBarButtonItemStyleBordered
    setToolbarItems([*backItem], animated:false)
  end

  # Interface buttons

  def logoButtonPressed
    p 'test'
  end

  # UIWebView methods

  def webViewDidFinishLoad(webView)
    MBProgressHUD.hideHUDForView(self.view, animated:true)
  end

  def webView(webView, didFailLoadWithError:error)
    webViewDidFinishLoad(webView)
  end

  def refreshWebView
    string1 = "#{BASEURL_WEBVIEW}#{@selectedTag.id}&candidacyIds="
    string2 = ""
    @selectedCandidacies.each_with_index do |candidacy, index|
      string2 << candidacy.id
      string2 << "," unless index+1 == @selectedCandidacies.length 
    end
    url = NSURL.URLWithString string1 + string2
    request = NSURLRequest.requestWithURL url
    @webView.loadRequest request
    hud = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    hud.labelText = "Récupération des données"
  end
end