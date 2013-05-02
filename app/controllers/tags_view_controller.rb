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
  end

  # UITableView methods

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

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

  def reloadData
    @table.reloadData
  end

end
