class PropositionsViewController < UIViewController
  BASEURL_WEBVIEW = 'http://voxe.org/webviews/comparisons?electionId=4ef479f8bc60fb0004000001&tagId='

  stylesheet :propositions

  layout :root do
    @webView = subview(UIWebView, :label)
  end

  def viewDidLoad
    super
  end

  def loadWebViewWithSelectedTag(selectedTag, andSelectedCandidacies:selectedCandidacies)
    urlString = "#{BASEURL_WEBVIEW}#{selectedTag.id}&candidacyIds=#{selectedCandidacies[0].id},#{selectedCandidacies[1].id}"
    p "#{urlString}"
    url = NSURL.URLWithString urlString
    request = NSURLRequest.requestWithURL url
    @webView.loadRequest request
  end
end
