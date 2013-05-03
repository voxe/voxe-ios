class CandidaciesViewController < UIViewController
  attr_accessor :viewController, :election, :selectedCandidacies, :delegate

  def selectedCandidacies
    @selectedCandidacies ||= []
  end

  def placeholderPhoto
    @placeholderPhoto ||= UIImage.imageNamed("photo_placeholder.png")
  end

  # UIViewController lifecycle

  stylesheet :candidacies

  layout :root do
    @table = subview(UITableView, :table)
  end

  def viewDidLoad
    super

    @table.dataSource = self
    @table.delegate = self
  end

  # UITableView methods

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    # Set the image
    photoRequest = NSURLRequest.requestWithURL(NSURL.URLWithString(@election.candidacies[indexPath.row].mediumPhotoURL))
    cell.imageView.setImageWithURLRequest(photoRequest,
      placeholderImage:placeholderPhoto,
      success:lambda do |request, response, image|
       cell.imageView.image = image
       cell.setNeedsLayout
     end,
     failure:nil)

    # Set the text
    cell.textLabel.text = @election.candidacies[indexPath.row].name

    # Add checkmark if needed
    if selectedCandidacies.include? @election.candidacies[indexPath.row]
      cell.accessoryType = UITableViewCellAccessoryCheckmark
    else
      cell.accessoryType = UITableViewCellAccessoryNone
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @election
    @election.candidacies.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    # Add or remove the candidacy from the selectedCandidacies array 
    candidacy = @election.candidacies[indexPath.row]
    if @selectedCandidacies.include? candidacy
      @selectedCandidacies.delete candidacy
    else
      @selectedCandidacies << candidacy
    end
    # Reload the row to make the checkmark appear of disappear
    @table.reloadRowsAtIndexPaths([*indexPath], withRowAnimation:UITableViewRowAnimationNone)
    # Send the selected candidacies to the ElectionViewController
    delegate.candidaciesViewController(self, didSelectCandidates:@selectedCandidacies)
  end

  # This function is called by the ElectionViewController upon reception of the data
  def reloadData
    @table.reloadData
  end
end
