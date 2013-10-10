class ElectionViewController < UINavigationController
  attr_accessor :election, :selectedTag, :selectedCandidacies
  attr_reader :deckViewController

  ELECTION_ID = '4f16fe2299c7a10001000012'

  def init
    load_election(ELECTION_ID)

    # Candidacies view controller (left view)
    @candidaciesViewController = CandidaciesViewController.alloc.init
    @candidaciesViewController.delegate = self

    # Propositions view controller (middle view with navigation controller)
    @propositionsViewController = PropositionsViewController.alloc.init
    @propositionsNavigationController = UINavigationController.alloc.initWithRootViewController(@propositionsViewController)

    # Tags View Controller (right view)
    @tagsViewController = TagsViewController.alloc.init
    @tagsViewController.delegate = self

    @deckViewController = IIViewDeckController.alloc.initWithCenterViewController(
      @propositionsNavigationController,
      leftViewController: @candidaciesViewController,
      rightViewController: @tagsViewController
      )

    return self
  end

  def selectedTag=(selectedTag)
    super
    @propositionsViewController.selectedTag = selectedTag
  end

  def selectedCandidacies=(selectedCandidacies)
    super
    @propositionsViewController.selectedCandidacies = selectedCandidacies
  end

  def selectedCandidacies
    @selectedCandidacies ||= []
  end

  def election=(election)
    super(election)
    @candidaciesViewController.election = election
    @candidaciesViewController.reloadData
    @tagsViewController.election = election
    @tagsViewController.reloadData

    @deckViewController.toggleLeftViewAnimated true
  end

  def load_election(election_id)
    BW::HTTP.get("http://voxe.org/api/v1/elections/#{election_id}") do |response|
      if response.ok?
        self.election = Election.new(BW::JSON.parse(response.body.to_str)['response']['election'])
      end
    end
  end

  # Delegate methods

  def candidaciesViewController(candidaciesViewController, didSelectCandidates:candidacies)
    self.selectedCandidacies = candidacies
    if @selectedTag == nil && candidacies.length == 2
      @deckViewController.toggleRightViewAnimated true
    elsif @selectedTag != nil && candidacies.length > 1
      @propositionsViewController.refreshWebView
    end
  end

  def tagsViewController(tagsViewController, didSelectTag:tag)
    self.selectedTag = tag
    @propositionsViewController.refreshWebView unless self.selectedCandidacies.length < 2
    @deckViewController.closeRightView
    if self.selectedCandidacies.length < 2
      @deckViewController.toggleLeftViewAnimated true
    end
  end

end
