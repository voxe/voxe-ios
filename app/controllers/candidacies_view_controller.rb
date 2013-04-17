class CandidaciesViewController < UIViewController
  attr_accessor :viewController, :election

  stylesheet :candidacies

  layout :root do
    @table = subview(UITableView, :table)
  end

  def viewDidLoad
    super

    @table.dataSource = self
    @table.delegate = self
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = data[indexPath.row].name

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @data
    @data.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    candidacy = @data[indexPath.row]
    if @selectedCandidacies.include? candidacy
      @selectedCandidacies.delete candidacy
    else
      @selectedCandidacies << candidacy
    end

    p "  #{@selectedCandidacies.length} selected candidacies"
  end
end
