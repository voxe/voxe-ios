class CountryElectionsTableViewController < UITableViewController
  attr_accessor :elections

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.textLabel.text = @elections[indexPath.row].name
    cell.textLabel.font = UIFont.fontWithName("Helvetica", size:17)
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @elections
    @elections.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end

end