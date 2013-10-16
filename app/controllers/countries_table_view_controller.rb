class CountriesTableViewController < UITableViewController
  attr_accessor :elections, :delegate

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
    self.table.delegate = delegate
  end

end