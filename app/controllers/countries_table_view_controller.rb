class CountriesTableViewController < UITableViewController
  attr_accessor :countries, :delegate

  def viewDidLoad
    super
    # hide back button
    self.navigationItem.hidesBackButton = true
    # Set button on navigation bar
    @logoButton = UIButton.buttonWithType(UIButtonTypeCustom)
    @logoButton.frame = [[0,0],[32,32]]
    @logoButton.setImage(UIImage.imageNamed("voxelogo.png"), forState:UIControlStateNormal)
    @logoButton.addTarget(self, action:'logoButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    navigationItem.titleView = @logoButton
  end

  def logoButtonPressed
    self.navigationController.popToRootViewControllerAnimated(true)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.textLabel.text = @countries[indexPath.row]
    cell.textLabel.font = UIFont.fontWithName("Helvetica", size:17)
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @countries
    @countries.length
  end

  def delegate=(delegate)
    self.tableView.delegate = delegate
  end

end