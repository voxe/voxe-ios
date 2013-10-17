class PropositionsViewController < UIViewController
  attr_accessor :selectedTag, :selectedCandidacies, :delegate
  BASEURL_WEBVIEW = 'http://voxe.org/webviews/comparisons?electionId=4ef479f8bc60fb0004000001&tagId='

  # UIViewController lifecycle

  stylesheet :elections
  layout :root do
    @webView = subview(UIWebView, :webview)
  end

  def viewDidLoad
    super
    view.backgroundColor = '#E7ECEE'.to_color

    # Set webview delegate
    @webView.delegate = self

    # Set button on navigation bar
    
    @logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
    @logoButton.frame = [[0,0],[32,32]]
    @logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
    @logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    navigationItem.titleView = @logoButton

    # Set back button
    backItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(101, target:@webView, action:'goBack')
    backItem.style = UIBarButtonItemStyleBordered
    navigationItem.setLeftBarButtonItem(backItem, animated:false)
  end

  # Interface buttons

  def logoButtonPressed
    # check if propositions view controller is displayed
    # if he is then display the countries table view
    # if not then push to the root view controller (propositions view controller)
    @logoButton.enabled = false
    BW::HTTP.get("http://voxe.org/api/v1/elections/search") do |response|
      if response.ok?

        # make of list of Election objects
        electionsFromJson = BW::JSON.parse(response.body.to_str)['response']['elections']
        @elections = electionsFromJson.map {|attributes|
          if attributes["published"] == true
            Election.new(attributes)
          end
        }

        # make a list of countries
        @countries = []
        @elections.each { |election|
          unless @countries.include?(election.country['name'])
            @countries.push(election.country['name'])
          end
        }

        # create the countries table view controller
        @countriesVC = CountriesTableViewController.alloc.init
        @countriesVC.delegate = self
        @countriesVC.countries = @countries
        self.navigationController.pushViewController(@countriesVC, animated:true)
      end
      @logoButton.enabled = true
    end
  end

  # UITableView delegate methods

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if tableView == @countriesVC.tableView
      # make a list of elections that happen in the selected country
      @countryElections = @elections.select { |election|
        election.country['name'] == @countries[indexPath.row]
      }
      # create the country elections table view controller
      electionsVC = CountryElectionsTableViewController.alloc.init
      electionsVC.elections = @countryElections
      electionsVC.delegate = self
      self.navigationController.pushViewController(electionsVC, animated:true)
    else
      self.navigationController.popToRootViewControllerAnimated(true)
      @delegate.propositionsViewController(self, didSelectElection:@countryElections[indexPath.row])
      p 'name'
    end
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
    hud.labelText = "Chargement"
  end
end