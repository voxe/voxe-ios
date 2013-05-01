class CandidaciesViewController < UIViewController
  attr_accessor :viewController, :election, :selectedCandidacies, :delegate

  def selectedCandidacies
    @selectedCandidacies ||= []
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

    cell.textLabel.text = @election.candidacies[indexPath.row].name

    if selectedCandidacies.include? @election.candidacies[indexPath.row]
      cell.accessoryType = UITableViewCellAccessoryCheckmark
    else
      cell.accessoryType = UITableViewCellAccessoryNone
    end

    cell
  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 0 unless @election
    @election.candidacies.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    candidacy = @election.candidacies[indexPath.row]
    if @selectedCandidacies.include? candidacy
      @selectedCandidacies.delete candidacy
    else
      @selectedCandidacies << candidacy
    end
    @table.reloadData

    if @selectedCandidacies.length == 2
      delegate.candidaciesViewController(self, didSelectCandidates:@selectedCandidacies)
    end
  end

  def reloadData
    @table.reloadData
  end
end
