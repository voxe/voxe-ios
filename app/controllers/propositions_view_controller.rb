class PropositionsViewController < UIViewController
  stylesheet :propositions

  layout :root do
    @webView = subview(UIWebView, :label)
  end

  def viewDidLoad
    super

    url = NSURL.URLWithString 'http://www.voxe.org'

    request = NSURLRequest.requestWithURL url

    #@webView.loadRequest request
  end
end
