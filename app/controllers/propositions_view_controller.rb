class PropositionsViewController < UIViewController
  attr_accessor :selectedTag, :selectedCandidacies, :delegate
  BASEURL_WEBVIEW = 'http://voxe.org/webviews/comparisons?electionId=4ef479f8bc60fb0004000001&tagId='

  # UIViewController lifecycle

  stylesheet :elections
  layout :root do
    @webView = subview(UIWebView, :webview)
  end

  def viewWillAppear(animated)
    super
    self.navigationController.navigationBarHidden = false
    self.viewDeckController.panningMode = IIViewDeckFullViewPanning
  end

  def viewDidLoad
    super
    view.backgroundColor = '#E7ECEE'.to_color

    # set webview delegate
    @webView.delegate = self

    # add items to navigation bar
    navigationItem.titleView = self.logoButton
    navigationItem.rightBarButtonItem = self.helpItem

    # display help label ('click button above to start')
    self.view.addSubview(self.helpLabel)

    # load elections
    self.loadElections

    # load tutorial if first launch
    if App::Persistence['firstLaunch'].nil?
      App::Persistence['firstLaunch'] = true
      self.tutorialButtonPressed
    end
  end

  # Instance variables

  def logoButton
    if @logoButton.nil?
      @logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
      @logoButton.frame = [[0,0],[32,32]]
      @logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
      @logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    end
    @logoButton
  end

  def backItem
    if @backItem.nil?
      @backItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(101, target:@webView, action:'goBack')
      @backItem.style = UIBarButtonItemStyleBordered
    end
    @backItemch
  end

  def helpItem
    if @helpItem.nil?
      helpButton = UIButton.buttonWithType(UIButtonTypeInfoLight) 
      helpButton.addTarget(self, action:'tutorialButtonPressed', forControlEvents:UIControlEventTouchUpInside)
      @helpItem = UIBarButtonItem.alloc.initWithCustomView(helpButton)
    end
    @helpItem
  end

  def helpLabel
    if @helpLabel.nil?
      offset = 45
      if Device.ios_version.to_f < 7
        offset = 0
      end
      @helpLabel = UILabel.alloc.initWithFrame([[10,offset],[300,100]])
      @helpLabel.text = "Pour commencer, appuyez sur \n le bouton ci-dessus \n pour choisir une élection"
      @helpLabel.font = UIFont.fontWithName("Helvetica", size:14)
      @helpLabel.lineBreakMode = UILineBreakModeWordWrap
      @helpLabel.numberOfLines = 0
      @helpLabel.textAlignment = UITextAlignmentCenter
    end
    @helpLabel
  end

  def tutorialVC
    tutorialVC = TutorialViewController.alloc.init
    tutorialVC.delegate = self
    tutorialVC
  end

  def countries
    if @countries.nil?
      @countries = []
      @elections.each { |election|
        unless @countries.any? {|country| country.name == election.country.name}
          @countries << election.country
        end
      }
    end
    @countries
  end

  def countriesVC
    if @countriesVC.nil?
      @countriesVC = CountriesTableViewController.alloc.init
      @countriesVC.delegate = self
      @countriesVC.countries = self.countries
    end
    @countriesVC
  end

  # Interface buttons

  def tutorialButtonPressed
    self.viewDeckController.panningMode = IIViewDeckNoPanning
    self.navigationController.pushViewController(self.tutorialVC, animated:true)
  end

  def logoButtonPressed
    # disable the logo button
    self.logoButton.enabled = false
    self.helpLabel.hidden = true

    if !@elections.nil?
      self.pushCountriesVC
    else
      BW::HTTP.get("http://voxe.org/api/v1/elections/search") do |response|
        if response.ok?
          # make of list of Election objects
          electionsFromJson = BW::JSON.parse(response.body.to_str)['response']['elections']
          @elections = electionsFromJson.map {|attributes|
            if attributes["published"] == true
              Election.new(attributes)
            end
          }.sort! { |a,b| b.date <=> a.date }
          self.pushCountriesVC
        else
          p 'couldnt fetch elections'
        end
      end
    end
  end

  def loadElections
    BW::HTTP.get("http://voxe.org/api/v1/elections/search") do |response|
      if response.ok?
          # make of list of Election objects
          electionsFromJson = BW::JSON.parse(response.body.to_str)['response']['elections']
          @elections = electionsFromJson.map {|attributes|
            if attributes["published"] == true
              Election.new(attributes)
            end
          }.sort! { |a,b| b.date <=> a.date }
      else
        p 'couldnt fetch elections'
      end
    end
  end

  def pushCountriesVC
    self.navigationController.pushViewController(self.countriesVC, animated:true)
    self.logoButton.enabled = true
  end

  # TutorialViewController delegate

  def tutorialViewControllerDismissed
    self.navigationController.popToRootViewControllerAnimated(false)
    self.logoButtonPressed
  end

  # UITableView delegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if tableView == self.countriesVC.tableView
      # make a list of elections that happen in the selected country
      @countryElections = @elections.select { |election|
        election.country.name == self.countries[indexPath.row].name
      }
      # create the country elections table view controller
      electionsVC = CountryElectionsTableViewController.alloc.init
      electionsVC.elections = @countryElections
      electionsVC.delegate = self
      self.navigationController.pushViewController(electionsVC, animated:true)
    else
      self.navigationController.popToRootViewControllerAnimated(true)
      @delegate.propositionsViewController(self, didSelectElection:@countryElections[indexPath.row])
    end
  end

  # UIWebView delegate

  def webViewDidFinishLoad(webView)
    MBProgressHUD.hideHUDForView(self.view, animated:true)
    if @resetBackButton
      @resetBackButton = false
    else
      navigationItem.setLeftBarButtonItem(self.backItem, animated:true)
    end
  end

  def webView(webView, didFailLoadWithError:error)
    webViewDidFinishLoad(webView)
  end

  def refreshWebView
    # reset the back button
    navigationItem.setLeftBarButtonItem(nil, animated:true)
    @resetBackButton = true

    # create and load request
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
    hud.labelText = "Chargement"
  end
end