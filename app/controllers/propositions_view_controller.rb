class PropositionsViewController < UIViewController
  attr_accessor :selectedTag, :selectedCandidacies, :delegate
  BASEURL_WEBVIEW = 'http://voxe.org/webviews/comparisons?electionId=4ef479f8bc60fb0004000001&tagId='

  # UIViewController lifecycle

  stylesheet :elections
  layout :root do
    @webView = subview(UIWebView, :webview)
    @tableElection = subview(UITableView, :table)
  end

  def viewDidLoad
    super
    view.backgroundColor = '#E7ECEE'.to_color

    # Set logo on navigation bar
    logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
    logoButton.frame = [[0,0],[32,32]]
    logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
    logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    navigationItem.titleView = logoButton

    # Set webview
    #@webview = layout(UIWebView, :webView)
    #@webView = UIWebView.alloc.initWithFrame([[0,0],[self.view.frame.size.width, self.view.frame.size.height]])
    @webView.delegate = self
    #self.view.addSubview(@webView)

    # Set table view with list of elections
    #@tableElection = UITableView.alloc.initWithFrame([[0, self.view.frame.size.height], [self.view.frame.size.width, self.view.frame.size.height]], style: UITableViewStylePlain)
    #@tableElection = layout(UITableView, :table)
    @tableElection.dataSource = self
    @tableElection.delegate = self
    #@tableElection.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0)
    #self.view.addSubview(@tableElection)

    # Set toolbar with back button
    #navigationController.setToolbarHidden(false, animated:false)
    backItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(101, target:@webView, action:'goBack')
    backItem.style = UIBarButtonItemStyleBordered
    navigationItem.setLeftBarButtonItem(backItem, animated:false)
    #setToolbarItems([*backItem], animated:false)
  end

  def viewWillAppear(animated)
    @tableHidden = true
    self.hideTable
  end

  def didRotateFromInterfaceOrientation(orientation)
    if @tableHidden == false
      self.showTable
    end
  end

  # Interface buttons

  def logoButtonPressed
    if @tableHidden == true
      hud = MBProgressHUD.showHUDAddedTo(@tableElection, animated:true)
      hud.labelText = "Chargement"
      self.showTable
      BW::HTTP.get("http://voxe.org/api/v1/elections/search") do |response|
        if response.ok?
          # make of list of Election objects
          electionsFromJson = BW::JSON.parse(response.body.to_str)['response']['elections']
          @elections = electionsFromJson.map {|attributes|
            if attributes["published"] == true
              Election.new(attributes)
            end
          }
#          @elections.reject! {|election| !election.published}

          # make a list of countries
          @countries = []
          @elections.each { |election|
            unless @countries.include?(election.country['name'])
              @countries.push(election.country['name'])
            end
          }

          @tableElection.reloadData
          MBProgressHUD.hideHUDForView(@tableElection, animated:true)
        end
      end
    else
      self.hideTable
      MBProgressHUD.hideHUDForView(@tableElection, animated:true)
    end
  end

  # Hide and show table

  def showTable
    UIView.beginAnimations(nil, context:nil)
    UIView.setAnimationDuration(0.5)
    UIView.setAnimationCurve(UIViewAnimationCurveEaseOut)
    UIView.setAnimationDelegate(self)

    # Navigation bar offset
    if Device.ios_version.to_f < 7
      navigationBarOffset = 0
    elsif Device.interface_orientation == :portrait
      navigationBarOffset = 64
    else
      navigationBarOffset = 50
    end
    @tableElection.frame = [[0,navigationBarOffset],[self.view.frame.size.width,self.view.frame.size.height-navigationBarOffset]]
    UIView.commitAnimations
    @tableHidden = false
  end

  def hideTable
    UIView.beginAnimations(nil, context:nil)
    UIView.setAnimationDuration(0.5)
    UIView.setAnimationCurve(UIViewAnimationCurveEaseOut)
    UIView.setAnimationDelegate(self)
    @tableElection.frame = [[0,self.view.frame.size.height],[self.view.frame.size.width,self.view.frame.size.height]]
    UIView.commitAnimations
    @tableHidden = true
  end

  # UITableView methods

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    #cell.textLabel.text = @elections[indexPath.row].name
    cell.textLabel.text = @countries[indexPath.row]
    cell.textLabel.font = UIFont.fontWithName("Helvetica", size:17)
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @countries
    @countries.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.hideTable
    #delegate.propositionsViewController(self, didSelectElection:@elections[indexPath.row])
    elections = @elections.select{ |election|
      election.country['name'] == @countries[indexPath.row]
    }
    electionsView = CountryElectionsTableViewController.alloc.init
    electionsView.elections = elections
    self.navigationController.pushViewController(electionsView, animated:true)
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