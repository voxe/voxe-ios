class PropositionsViewController < UIViewController
    attr_accessor :selectedTag, :selectedCandidacies
  BASEURL_WEBVIEW = 'http://voxe.org/webviews/comparisons?electionId=4ef479f8bc60fb0004000001&tagId='

  stylesheet :propositions

  layout :root do
    @webView = subview(UIWebView, :label)
  end

  def viewDidLoad
    super
    @webView.delegate = self
  end

  def webViewDidFinishLoad(webView)
    p "finish load"
  end

  def refreshWebView
    string1 = "#{BASEURL_WEBVIEW}#{@selectedTag.id}&candidacyIds="
    string2 = ""
    @selectedCandidacies.each_with_index do |candidacy, index|
      string2 << candidacy.id
      string2 << "," unless index+1 == @selectedCandidacies.length 
    end
    urlString = string1 + string2
    p "#{urlString}"
    url = NSURL.URLWithString urlString
    request = NSURLRequest.requestWithURL url
    @webView.loadRequest request
  end
end