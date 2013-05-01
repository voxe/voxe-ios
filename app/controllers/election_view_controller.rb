class ElectionViewController < UINavigationController
  attr_accessor :election
  attr_reader :deckViewController

  ELECTION_ID = '4f16fe2299c7a10001000012'

  def init
    load_election(ELECTION_ID)

    @candidaciesViewController = CandidaciesViewController.alloc.init
    @candidaciesViewController.delegate = self
    @propositionsViewController = PropositionsViewController.alloc.init
    @tagsViewController = TagsViewController.alloc.init

    @deckViewController = IIViewDeckController.alloc.initWithCenterViewController(
      @propositionsViewController,
      leftViewController: @candidaciesViewController,
      rightViewController: @tagsViewController
    )

    return self
  end

  def election=(election)
    super(election)
    @candidaciesViewController.election = election
    @candidaciesViewController.reloadData
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
  
  def candidaciesViewController(candidaciesViewController, didSelectCandidates:selectedCandidacies)
    @tagsViewController.candidacies = selectedCandidacies
    @deckViewController.toggleRightViewAnimated true
  end
end
