class ElectionViewController < UINavigationController
  attr_accessor :election, :selectedTag, :selectedCandidacies
  attr_reader :deckViewController

  ELECTION_ID = '4f16fe2299c7a10001000012'

  def init

    # Candidacies view controller (left view)
    @candidaciesViewController = CandidaciesViewController.alloc.init
    @candidaciesViewController.delegate = self
    @candidaciesNavigationController = UINavigationController.alloc.initWithRootViewController(@candidaciesViewController)

    # Propositions view controller (middle view with navigation controller)
    @propositionsViewController = PropositionsViewController.alloc.init
    @propositionsViewController.delegate = self
    @propositionsNavigationController = UINavigationController.alloc.initWithRootViewController(@propositionsViewController)

    # Tags View Controller (right view)
    @tagsViewController = TagsViewController.alloc.init
    @tagsViewController.delegate = self
    @tagsNavigationController = UINavigationController.alloc.initWithRootViewController(@tagsViewController)

    @deckViewController = IIViewDeckController.alloc.initWithCenterViewController(
      @propositionsNavigationController,
      leftViewController: @candidaciesNavigationController,
      rightViewController: @tagsNavigationController
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
    if candidacies.length == 2
      if @selectedTag == nil
        @deckViewController.toggleRightViewAnimated true
      else
        @propositionsViewController.refreshWebView
        @deckViewController.closeLeftView
      end
    end
  end

  def propositionsViewController(propositionsViewController, didSelectElection:election)
    self.selectedCandidacies = nil
    self.selectedTag = nil
    self.election = election
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
