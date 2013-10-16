class TagsViewController < UIViewController
  attr_accessor :election, :delegate

  # UIViewController lifecycle

  stylesheet :tags

  layout :root do
    @table = subview(UITableView, :table)
  end

  def viewDidLoad
    super

    @table.dataSource = self
    @table.delegate = self
    self.title = 'Thèmes'
  end

  # UITableView methods

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      TagsTableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    # Set the image
    iconRequest = NSURLRequest.requestWithURL(NSURL.URLWithString(@election.tags[indexPath.row].iconURL))
    cell.imageView.setImageWithURLRequest(iconRequest,
      placeholderImage:nil,
      success:lambda do |request, response, image|
       cell.imageView.image = image
       cell.setNeedsLayout
     end,
      failure:nil)

    # Set the text
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap
    cell.textLabel.numberOfLines = 0
    cell.textLabel.font = UIFont.fontWithName("Helvetica", size:17)
    cell.textLabel.text = @election.tags[indexPath.row].name

    cell
  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @election
    @election.tags.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    selectedTag = @election.tags[indexPath.row]
    delegate.tagsViewController(self, didSelectTag:selectedTag)
  end

def tableView(tableView, heightForRowAtIndexPath:indexPath)
    cellText = @election.tags[indexPath.row].name
    cellFont = UIFont.fontWithName("Helvetica", size:17)
    labelSize = cellText.sizeWithFont(cellFont,
      constrainedToSize:[280-20,500],
      lineBreakMode:UILineBreakModeWordWrap)

  labelSize.height + 25
end

  def reloadData
    @table.reloadData
  end

end
