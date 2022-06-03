defmodule BrutalChat.Names do
  @adjectives ~w(
    abject
    able
    abnormal
    abominable
    abrasive
    abrupt
    absent
    absolute
    abstracted
    abstract
    abstruse
    absurd
    abundant
    abusive
    abysmal
    academical
    acceptable
    accessible
    accidental
    according
    accurate
    accusing
    acid
    acoustical
    active
    actual
    acute
    adamant
    additional
    adept
    adequate
    adjacent
    adjectival
    administrative
    admirable
    admiring
    admitted
    adorable
    adoring
    adroit
    advantageous
    adventurous
    adverse
    advised
    aerodynamical
    aesthetical
    affable
    affectionate
    affirmative
    affluent
    aggressive
    agile
    agonizing
    agreeable
    aimless
    airy
    alarming
    alert
    algebraical
    alleged
    allegorical
    allusive
    al
    alphabetical
    alternate
    alternative
    altruistical
    amazing
    ambidextrous
    ambiguous
    ambitious
    ambivalent
    amiable
    amicable
    amoral
    amorous
    amorphous
    amp
    amusing
    analogous
    analyticalal
    analytical
    anarchical
    anatomical
    angelical
    angry
    animated
    annoying
    annual
    anoma
    anonymous
    antagonistical
    antiseptical
    antithetical
    anxious
    apathetical
    apologetical
    appalling
    apparent
    appetizing
    app
    apposite
    appreciable
    appreciative
    apprehensive
    appropriate
    approving
    approximate
    apt
    arbitrary
    archaical
    architectural
    arch
    ardent
    arduous
    arguable
    aristocratical
    arithmetical
    arrogant
    artful
    articulate
    artificial
    artistical
    artless
    asexual
    ashamed
    assemble
    assertive
    assiduous
    assured
    astonishing
    astounding
    astronomical
    astute
    asymmetrical
    asymptotical
    asynchronous
    athletical
    atmospherical
    atrocious
    attentive
    attractive
    attributive
    atypical
    audacious
    audible
    aural
    auspicious
    austere
    authentical
    authoritative
    autocratical
    automatical
    autonomous
    avaricious
    avid
    avoidable
    avowed
    awesome
    awful
    awkward
    axiomatical
    bad
    bald
    baleful
    barbarous
    bare
    base
    bashful
    basical
    bawdy
    beast
    beauteous
    beautiful
    becoming
    beggar
    begrudging
    beguiling
    belated
    belligerent
    bel
    beneficent
    beneficial
    benevolent
    benign
    biannual
    biennial
    bilateral
    bil
    bimonth
    biological
    biting
    bitter
    biweek
    bizarre
    blameless
    bland
    blank
    blasphemous
    blatant
    bleak
    bleary
    blessed
    blinding
    blind
    blissful
    blithe
    bloodless
    blunt
    boastful
    body
    boisterous
    bold
    boorish
    boring
    bossy
    bountiful
    boyish
    brash
    brave
    brazen
    breathless
    breathtaking
    breezy
    brief
    bright
    brilliant
    brisk
    brist
    broad
    brother
    brusk
    brusque
    brutal
    brutish
    bubble
    bul
    buoyant
    bureaucratical
    bur
    busy
    butterf
    cagy
    callous
    calm
    candid
    canny
    cantankerous
    capable
    capacious
    capricious
    careful
    careless
    carnal
    casual
    catastrophical
    categorical
    catty
    causal
    caustical
    cautious
    ceaseless
    censorious
    central
    ceremonial
    ceremonious
    certain
    chaotical
    characteristical
    chary
    charitable
    charming
    chaste
    chatty
    cheap
    cheeky
    cheerful
    cheery
    cheerless
    chemical
    chief
    childish
    chill
    chivalrous
    choppy
    chronical
    chronological
    churlish
    circuitous
    circumstantial
    civil
    clandestine
    classical
    clean
    clear
    clever
    clinical
    close
    clownish
    clumsy
    coarse
    cocky
    cogent
    coherent
    cohesive
    coincidental
    cold
    collective
    colloquial
    colorful
    colossal
    come
    comfortable
    comforting
    comical
    commendable
    commercial
    common
    communal
    compact
    comparable
    comparative
    compassionate
    compatible
    compelling
    competent
    competitive
    complacent
    complaisant
    complete
    comp
    comprehensive
    compulsive
    compulsory
    computational
    conceivable
    concentrical
    conceptual
    concise
    conclusive
    concrete
    concurrent
    condescending
    conditional
    confessed
    confidential
    confident
    confused
    confusing
    congenial
    congenital
    conscientious
    conscious
    consecutive
    consequent
    conservative
    considerable
    considerate
    consistent
    conspicuous
    constant
    constitutional
    constructive
    contemporaneous
    contemptible
    contemptuous
    contented
    contentious
    continual
    continuous
    contractual
    contrary
    contrite
    controversial
    contume
    convenient
    conventional
    conversational
    converse
    convincing
    convulsive
    cool
    cooperative
    copious
    cordial
    correct
    corresponding
    corrupt
    cosmetical
    cosmical
    cost
    countable
    courageous
    courteous
    court
    covert
    covetous
    coward
    coy
    cozy
    crabby
    crack
    crafty
    crass
    craven
    crazy
    creative
    credible
    creditable
    credulous
    creepy
    criminal
    crink
    crisp
    critical
    crooked
    cross
    crucial
    crude
    cruel
    crumble
    cryptical
    cudd
    cultural
    cumulative
    cunning
    curious
    cur
    current
    cursory
    curt
    customary
    cute
    cyclical
    cynical
    day
    dainty
    dal
    damnable
    damp
    dangerous
    dank
    daring
    dark
    dashing
    dastard
    dauntless
    dead
    dear
    death
    debonair
    decadent
    deceitful
    decent
    deceptive
    decided
    decisive
    decorous
    deep
    defensive
    deferential
    defiant
    definite
    definitive
    deft
    dejected
    deliberate
    delicate
    delicious
    delightful
    delinquent
    delirious
    demented
    democratical
    demographical
    demonstrable
    demonstrative
    demure
    dense
    dependable
    deplorable
    depressing
    derisive
    descriptive
    deserved
    desirable
    desolate
    despairing
    desperate
    despicable
    despondent
    destructive
    devilish
    devious
    devoted
    devout
    dexterous
    dextrous
    diabolical
    diagonal
    diametrical
    different
    diffident
    diffuse
    digital
    diligent
    dil
    dillydal
    dim
    diplomatical
    direct
    disadvantageous
    disagreeable
    disappointing
    disapproving
    disastrous
    disconnected
    disconsolate
    discontented
    discouraging
    discourteous
    discreet
    disdainful
    disgraceful
    disgusted
    disgusting
    dishonest
    dishonorable
    disinterested
    disjointed
    disloyal
    dismal
    disobedient
    disorder
    dispassionate
    disproportionate
    disreputable
    disrespectful
    dissolute
    distant
    distasteful
    distinctive
    distinct
    distressing
    distrustful
    disturbing
    diurnal
    diverse
    divine
    divisive
    dizzy
    docile
    dogged
    dogmatical
    doy
    doleful
    domestical
    dominant
    doting
    double
    doubtful
    doubtless
    dour
    dowdy
    drab
    dragon
    dramatical
    drastical
    dreadful
    dreamy
    dreary
    dry
    drizz
    droll
    drowsy
    drunken
    dry
    dubious
    dull
    due
    dumb
    durable
    dutiful
    dynamical
    eager
    ear
    earnest
    earth
    easy
    easter
    eccentrical
    eclectical
    ecological
    economical
    ecstatical
    ecumenical
    editorial
    educational
    eery
    effective
    effectual
    efficacious
    efficient
    effortless
    effusive
    egotistical
    egregious
    elaborate
    elder
    electrical
    electronical
    elegant
    elliptical
    eloquent
    elusive
    embarrassing
    eminent
    emotional
    emphatical
    empirical
    empty
    enchanting
    encouraging
    endearing
    endless
    energetical
    engaging
    enigmatical
    enormous
    entertaining
    enthusiastical
    entire
    enviable
    envious
    environmental
    equable
    equal
    equitable
    equivalent
    equivocal
    erect
    erotical
    erratical
    erroneous
    erudite
    esoterical
    especial
    essential
    eternal
    ethereal
    ethical
    ethnical
    euphemistical
    evasive
    even
    eventful
    eventual
    evident
    evil
    exacting
    exact
    exceeding
    excellent
    exceptional
    excessive
    excited
    exciting
    exclusive
    excruciating
    exhaustive
    existential
    exorbitant
    exotical
    expansive
    expectant
    expedient
    expeditious
    expensive
    experimental
    expert
    explicit
    explosive
    exponential
    expressive
    express
    exquisite
    extemporaneous
    extensive
    external
    extraneous
    extraordinary
    extravagant
    extreme
    extrinsical
    exuberant
    exultant
    fabulous
    facetious
    facial
    factual
    faint
    fair
    faithful
    faithless
    fallacious
    fallible
    false
    faltering
    familiar
    famy
    famous
    fanatical
    fanciful
    fancy
    fantastical
    fashionable
    fastidious
    fatal
    fateful
    father
    fatuous
    faulty
    faultless
    favorable
    fearful
    fearless
    feasible
    federal
    feeble
    feeling
    ferocious
    fervent
    fervid
    festive
    fetching
    feverish
    fidd
    fiendish
    fierce
    figurative
    fil
    final
    financial
    fine
    finite
    firef
    firm
    first
    fiscal
    fitful
    fit
    fitting
    fixed
    flagrant
    flamboyant
    flashy
    flat
    flattering
    flawless
    fleeting
    flesh
    flexible
    flimsy
    flippant
    flirtatious
    florid
    fluent
    fluid
    fly
    fond
    foolish
    forbidding
    forceful
    forcible
    forgetful
    forlorn
    formal
    former
    formidable
    formless
    forthright
    fortnight
    fortuitous
    fortunate
    foul
    fourth
    fractional
    fractious
    fragrant
    frank
    frantical
    fraternal
    fraudulent
    free
    frenetical
    frenzied
    frequent
    fresh
    fretful
    friend
    frightening
    frightful
    frigid
    fril
    frisky
    frivolous
    frontal
    frosty
    frugal
    fruitful
    fruitless
    full
    functional
    fundamental
    funereal
    funny
    furious
    furtive
    fussy
    futile
    fuzzy
    gay
    gainful
    gallant
    game
    gang
    garish
    garrulous
    gaudy
    gawky
    gay
    general
    generical
    generous
    genetical
    genial
    gentleman
    gent
    genuine
    geographical
    geological
    geometrical
    ghast
    ghost
    giddy
    gigg
    ginger
    girlish
    glacial
    glad
    glamorous
    glaring
    gleeful
    glible
    global
    gloomy
    glorious
    glowing
    glum
    gluttonous
    gnarl
    god
    good
    gorgeous
    graceful
    graceless
    gracious
    gradual
    grammatical
    grand
    graphical
    grateful
    gratuitous
    gravel
    grave
    great
    greedy
    gregarious
    grievous
    grim
    gris
    grist
    grizz
    groggy
    gross
    grotesque
    groundless
    grudging
    gruesome
    gruff
    grumpy
    guarded
    guilty
    gull
    habitual
    halfhearted
    halting
    handy
    handsome
    haphazard
    happy
    hardheaded
    hardhearted
    hardy
    hard
    harmful
    harmless
    harmonical
    harmonious
    harsh
    hasty
    hateful
    haughty
    haunting
    hazy
    healthful
    healthy
    hearty
    heartless
    heated
    heaven
    heavy
    hectical
    heedless
    heinous
    hellish
    helpful
    helpless
    hermetical
    heroical
    hesitant
    hesitating
    hideous
    hierarchical
    high
    hilarious
    hillbil
    hil
    historical
    hoarse
    hollow
    hol
    ho
    home
    homy
    homogeneous
    honest
    honorable
    hopeful
    hopeless
    horizontal
    horrendous
    horrible
    horrid
    horsef
    hospitable
    hostile
    hotheaded
    hot
    hour
    huffy
    huge
    humane
    human
    humble
    humorous
    hungry
    hurried
    husky
    hydraulical
    hygienical
    hypercritical
    hypnotical
    hypocritical
    hypothetical
    hysterical
    icy
    idealistical
    ideal
    identical
    ideological
    idiomatical
    idiotical
    idle
    ignoble
    ignominious
    ignorant
    illegal
    illegible
    illegitimate
    illicit
    illogical
    imaginable
    imaginative
    immaculate
    immature
    immeasurable
    immediate
    immense
    imminent
    immoderate
    immodest
    immoral
    immortal
    immovable
    immutable
    impartial
    impassive
    impatient
    impeccable
    impenetrable
    imperative
    imperceptible
    imperfect
    imperial
    imperious
    impersonal
    impertinent
    imperturbable
    impetuous
    impious
    impish
    implacable
    implausible
    implicit
    imp
    impolite
    important
    imposing
    impossible
    impotent
    impracticable
    imprecise
    impregnable
    impressive
    improbable
    improper
    improvident
    impudent
    impulsive
    impure
    inaccurate
    inadequate
    inadvertent
    inane
    inappropriate
    inarticulate
    inaudible
    incalculable
    incessant
    incidental
    incisive
    inclusive
    incoherent
    incomparable
    incompatible
    incompetent
    incomplete
    incomprehensible
    inconceivable
    inconclusive
    incongruous
    inconsequential
    inconsiderate
    inconsistent
    inconspicuous
    incontestable
    incontrovertible
    inconvenient
    incorrect
    incorrigible
    increasing
    incredible
    incredulous
    incurable
    indecent
    indecisive
    indefatigable
    indefensible
    indefinable
    indefinite
    indelible
    indelicate
    independent
    indescribable
    indestructible
    indeterminate
    indifferent
    indignant
    indirect
    indiscreet
    indiscriminate
    indispensable
    indisputable
    indistinct
    individual
    indivisible
    indolent
    indomitable
    indubitable
    indulgent
    industrial
    industrious
    ineffable
    ineffective
    ineffectual
    inefficient
    inelegant
    ineluctable
    inept
    inert
    inescapable
    inestimable
    inevitable
    inexcusable
    inexhaustible
    inexorable
    inexpensive
    inexplicable
    inextricable
    infallible
    infamous
    infectious
    infinite
    infinitesimal
    inflexible
    influential
    informal
    infrequent
    infuriating
    ingenious
    ingenuous
    ingratiating
    inherent
    inhumane
    inhuman
    inimical
    inimitable
    initial
    innate
    innocent
    innocuous
    inoffensive
    inordinate
    inquiring
    inquisitive
    insane
    insatiable
    inscrutable
    insecure
    insensible
    insensitive
    inseparable
    insidious
    insignificant
    insincere
    insistent
    insolent
    instantaneous
    instant
    instinctive
    instructive
    insufferable
    insufficient
    intangible
    intellectual
    intelligent
    intelligible
    intense
    intensive
    intentional
    intent
    interactive
    interchangeable
    interesting
    interminable
    intermittent
    internal
    international
    intimate
    intolerable
    intransitive
    intravenous
    intrepid
    intricate
    intriguing
    intrinsical
    intuitive
    invariable
    inverse
    invidious
    invincible
    invisible
    inviting
    involuntary
    invulnerable
    inward
    irate
    ironical
    irrational
    irregular
    irrelevant
    irremediable
    irreparable
    irresistible
    irresolute
    irresponsible
    irretrievable
    irreverent
    irreversible
    irrevocable
    irritable
    irritating
    jagged
    jaunty
    jealous
    jeering
    jelly
    jerky
    jocose
    jocular
    jocund
    joint
    joking
    jolly
    jovial
    joyful
    joyous
    jubilant
    judicial
    judicious
    justifiable
    just
    keen
    kind
    king
    knight
    knowing
    knowledgeable
    laborious
    lackadaisical
    laconical
    lame
    lamentable
    languid
    languorous
    large
    lascivious
    lasting
    last
    late
    lateral
    latter
    laudable
    laughable
    laughing
    lavish
    lawful
    lawless
    lax
    lazy
    lecherous
    legal
    legible
    legitimate
    leisure
    lengthy
    lenient
    lethal
    lethargical
    lewd
    liberal
    licentious
    lighthearted
    light
    like
    limpid
    limp
    lineal
    linear
    lingering
    listless
    literal
    live
    livid
    local
    lofty
    logical
    logistical
    lone
    longing
    longitudinal
    loose
    lopsided
    lord
    loud
    love
    loving
    low
    loyal
    lucid
    lucky
    lucrative
    ludicrous
    lugubrious
    luminous
    lurid
    luscious
    lustful
    lusty
    luxuriant
    luxurious
    lyrical
    maddening
    mad
    magical
    magisterial
    magnanimous
    magnetical
    magnificent
    maiden
    main
    majestical
    major
    malevolent
    malicious
    malignant
    manful
    manifest
    man
    manner
    mannish
    manual
    marginal
    marked
    marvellous
    marvelous
    massive
    masterful
    master
    materialistical
    material
    maternal
    mathematical
    matron
    mature
    mawkish
    maximal
    meager
    meal
    meaningful
    mean
    measle
    measurable
    mechanical
    medical
    medicinal
    meditative
    meek
    melancho
    mellifluous
    melodical
    melodious
    melodramatical
    memorable
    menacing
    menial
    mental
    merciful
    merciless
    mere
    meritorious
    merry
    messy
    metaphorical
    methodical
    meticulous
    metrical
    microscopical
    mighty
    mild
    militant
    military
    mindboggling
    mindful
    mindless
    minimal
    minute
    miraculous
    mirthful
    mischievous
    miserable
    miser
    misguided
    mistaken
    misty
    mocking
    moderate
    modest
    modish
    moist
    momentary
    monetary
    monotonical
    monotonous
    monstrous
    month
    monumental
    moody
    moral
    morbid
    morose
    mortal
    most
    mother
    mournful
    moving
    mulish
    mundane
    municipal
    murderous
    murky
    musical
    mute
    mutinous
    mutual
    mysterious
    mystical
    naive
    naked
    name
    narrow
    nasal
    nasty
    national
    natty
    natural
    naughty
    nauseating
    nautical
    near
    neat
    necessary
    needless
    nefarious
    negative
    neglectful
    negligent
    negligible
    neighbor
    nerveless
    nervous
    neurotical
    neutral
    new
    nice
    niggard
    night
    nimble
    noble
    nocturnal
    noiseless
    noisy
    nominal
    nonchalant
    noncommittal
    nonsensical
    normal
    northeaster
    norther
    northwester
    nostalgical
    notable
    noticeable
    notional
    notorious
    numble
    numerical
    nutritional
    obdurate
    obedient
    objectionable
    objective
    obliging
    oblique
    oblivious
    obnoxious
    obscene
    obscure
    obsequious
    observable
    observant
    obsessive
    obstinate
    obstructive
    obtrusive
    obtuse
    obvious
    occasional
    odd
    odious
    offensive
    offhanded
    official
    officious
    oy
    ominous
    only
    opaque
    open
    operational
    oppressive
    optical
    optimistical
    optional
    oral
    order
    ordinary
    organical
    original
    ornate
    ostensible
    ostentatious
    otherworld
    outlandish
    outrageous
    outspoken
    outstanding
    outward
    over
    oversupp
    overt
    overwhelming
    pacifical
    painful
    painless
    painstaking
    palpable
    panop
    paradoxical
    parenthetical
    partial
    particular
    part
    passable
    passionate
    passive
    patent
    paternal
    pathetical
    pathological
    patient
    patriotical
    patronizing
    peaceable
    peaceful
    pear
    pebble
    peculiar
    pedantical
    peevish
    penitent
    pensive
    perceptible
    perceptive
    peremptory
    perennial
    perfect
    perfunctory
    perilous
    periodical
    permanent
    permissible
    permissive
    pernicious
    perpetual
    persistent
    personal
    persuasive
    pert
    perverse
    pessimistical
    petty
    petulant
    phenomenal
    philanthropical
    philate
    philosophical
    phlegmatical
    phonetical
    phonical
    photographical
    physical
    pictorial
    piercing
    pimp
    pious
    piteous
    pithy
    pitiable
    pitiful
    pitiless
    placid
    plain
    plaintive
    plausible
    playful
    pleasant
    pleasing
    pleasurable
    plentiful
    pneumatical
    poetical
    poignant
    pointed
    pointless
    poisonous
    polite
    political
    pompous
    ponderous
    poor
    popular
    portentous
    port
    positive
    possessive
    possible
    posthumous
    potbel
    potential
    powerful
    powerless
    practicable
    practical
    pragmatical
    precarious
    precious
    precipitate
    precipitous
    precise
    precocious
    predictable
    predominant
    preeminent
    preemptive
    preferable
    preferential
    premature
    preposterous
    present
    presumable
    presumptuous
    pretentious
    pretty
    previous
    prick
    priest
    primary
    primitive
    prim
    prince
    principal
    private
    probable
    problematical
    prodigious
    productive
    profane
    professional
    proficient
    profitable
    profound
    profuse
    progressive
    prohibitive
    prolifical
    prominent
    promiscuous
    promising
    prompt
    proper
    prophetical
    proportional
    proportionate
    prosaical
    prosperous
    protective
    proud
    provable
    proverbial
    providential
    provident
    provisional
    provocative
    prudent
    prudish
    psychical
    psychological
    public
    pugnacious
    punctilious
    punctual
    pungent
    pure
    puritanical
    purported
    purposeful
    purpose
    quaint
    qualitative
    quarter
    queasy
    queen
    queer
    querulous
    questionable
    questioning
    quick
    quiet
    quizzical
    racial
    racy
    radial
    radiant
    radical
    ragged
    rakish
    rampant
    rancorous
    random
    rapacious
    rapid
    rare
    rascal
    rash
    rational
    raucous
    ravenous
    ravishing
    ready
    realistical
    real
    reasonable
    reassuring
    rebellious
    recent
    receptive
    reciprocal
    reckless
    recognizable
    recursive
    redundant
    reflexive
    refreshing
    regal
    regional
    regretful
    regrettable
    regular
    relative
    relentless
    relevant
    reliable
    religious
    reluctant
    remarkable
    remorseful
    remorseless
    remote
    repeatable
    repeated
    reported
    reprehensible
    reproachful
    repulsive
    reputable
    reputed
    resentful
    reserved
    resigned
    resolute
    resonant
    resounding
    resourceful
    respectable
    respectful
    respective
    resplendent
    responsible
    responsive
    restful
    restive
    restless
    restrictive
    retroactive
    retrospective
    reverent
    revolting
    rhetorical
    rhythmical
    rich
    ridiculous
    righteous
    rightful
    right
    rigid
    rigorous
    ripe
    ritual
    robust
    roguish
    romantical
    rosy
    rough
    round
    routine
    royal
    rude
    rueful
    rugged
    ruinous
    rustical
    ruthless
    sacred
    sadistical
    sad
    safe
    saint
    salacious
    sanctimonious
    sane
    sarcastical
    sardonical
    sartorial
    satanical
    satirical
    satisfactory
    saucy
    savage
    scaly
    scandalous
    scanty
    scarce
    scathing
    scenical
    schematical
    scholarly
    scholastical
    scientifical
    scornful
    scraggly
    scrupulous
    scurrilous
    searching
    seasonal
    secondary
    second
    secretive
    secret
    secure
    sedate
    seductive
    seeming
    seemly
    seismical
    selective
    selfish
    selfless
    semantical
    semimonth
    semiweek
    sensational
    senseless
    sensible
    sensitive
    sensual
    sensuous
    sentimental
    separate
    sequential
    serene
    serial
    serious
    several
    severe
    sexual
    shabby
    shaky
    shameful
    shameless
    shapeless
    shape
    sharp
    sheepish
    shifty
    shocking
    shoddy
    short
    shortsighted
    showy
    shrewd
    shril
    shy
    sickening
    sick
    signal
    significant
    silent
    silly
    similar
    simp
    simultaneous
    sincere
    sinful
    sing
    singular
    sister
    skeptical
    skillful
    slack
    slattern
    slavish
    sleazy
    sleek
    sleepy
    slick
    slight
    sly
    sloppy
    sloven
    slow
    sluggish
    sly
    smart
    smel
    smiling
    smooth
    smug
    sneering
    snug
    sober
    sociable
    social
    soft
    soggy
    soldier
    sole
    solemn
    solicitous
    solid
    somber
    sombre
    soothing
    sordid
    sore
    sorrowful
    soulful
    soundless
    sound
    sour
    southeaster
    souther
    southwester
    spacious
    spare
    sparing
    sparse
    spasmodical
    spatial
    special
    specifical
    specious
    spectacular
    speedy
    spind
    spiral
    spiritual
    spiteful
    splendid
    spontaneous
    sporadical
    spotless
    spright
    spry
    spurious
    square
    squeamish
    squigg
    staggering
    staid
    stark
    startling
    stately
    statical
    statistical
    staunch
    steadfast
    steady
    stealthy
    steely
    steep
    stern
    stiff
    stingy
    stoical
    stolid
    stony
    stormy
    stout
    stragg
    straightforward
    strange
    strategical
    strenuous
    strict
    strident
    striking
    stringent
    strong
    structural
    stubble
    stubborn
    studious
    stuffy
    stunning
    stupendous
    stupid
    sturdy
    stylish
    stylistical
    suave
    subconscious
    subjective
    sublime
    subliminal
    subsequent
    substantial
    subtle
    successful
    successive
    succinct
    sudden
    sufficient
    suggestive
    suitable
    sulky
    sullen
    summary
    superble
    superficial
    superlative
    superstitious
    supple
    supposed
    supreme
    sure
    surgical
    surly
    surprising
    surreptitious
    suspicious
    sweet
    swift
    swirly
    symbolical
    symmetrical
    symmetric
    sympathetical
    synchronous
    syntactical
    synthetical
    systematical
    tacit
    tactful
    tactical
    tactless
    tall
    tame
    tangible
    tantalizing
    tardy
    tart
    tasteful
    tasteless
    taut
    tearful
    technical
    technological
    tedious
    telepathical
    telling
    temperamental
    tempestuous
    temporal
    temporary
    tempting
    tenacious
    tendentious
    tender
    tense
    tentative
    tenuous
    terminal
    term
    terrible
    terrifical
    terrifying
    terse
    testy
    textual
    thankful
    thankless
    theatrical
    thematical
    theoretical
    therapeutical
    thermal
    thick
    thin
    third
    thirsty
    thorough
    thoughtful
    thoughtless
    threatening
    thrifty
    throaty
    tidy
    tight
    time
    timid
    timorous
    ting
    tipsy
    tireless
    tiresome
    tolerable
    tolerant
    topical
    topological
    tortuous
    total
    touching
    tough
    traditional
    tragical
    tranquil
    transcendental
    transitive
    transparent
    transverse
    treacherous
    tremendous
    tremulous
    trim
    trip
    trite
    triumphant
    trivial
    troll
    truculent
    true
    trustful
    truthful
    tuneful
    tuneless
    turbulent
    turgid
    typical
    typographical
    tyrannical
    ubiquitous
    ugly
    ultimate
    ultrasonical
    unacceptable
    unaccountable
    unalterable
    unambiguous
    unanimous
    unashamed
    unavoidable
    unbearable
    unbelievable
    uncanny
    unceasing
    unceremonious
    uncertain
    uncharacteristical
    uncharitable
    unclean
    uncomfortable
    uncommon
    uncompromising
    unconcerned
    unconditional
    unconscionable
    unconscious
    uncontrollable
    unconventional
    unconvincing
    unctuous
    undeniable
    underbel
    underhanded
    understandable
    understanding
    undeserved
    undoubted
    undue
    unearth
    uneasy
    unequal
    unequivocal
    unerring
    uneven
    uneventful
    unexpected
    unfailing
    unfair
    unfaithful
    unfavorable
    unfeeling
    unflinching
    unforgettable
    unfortunate
    unfriendly
    ungainly
    ungentleman
    ungod
    ungrateful
    unhappy
    unhesitating
    unholy
    uniform
    unilateral
    unintelligible
    unintentional
    unique
    universal
    unjust
    unkind
    unknowing
    unlawful
    unlike
    unlucky
    unmanly
    unmannerly
    unmerciful
    unmistakable
    unnatural
    unnecessary
    unobtrusive
    unofficial
    unpleasant
    unquestionable
    unquestioning
    unrealistical
    unreasonable
    unrelenting
    unreserved
    unruly
    unscrupulous
    unseasonable
    unseemly
    unselfish
    unsight
    unspeakable
    unsteady
    unsuccessful
    unsuitable
    unthinking
    untimely
    untiring
    untruthful
    unusual
    unutterable
    unwilling
    unwise
    unwitting
    unworld
    uproarious
    upward
    urgent
    useful
    useless
    usual
    utter
    vacant
    vacuous
    vague
    vain
    valiant
    valid
    variable
    various
    vast
    vehement
    venal
    vengeful
    venomous
    verbal
    very
    veritable
    vertical
    vibrant
    vicarious
    vicious
    victorious
    vigilant
    vigorous
    vile
    vindictive
    violent
    virtual
    virtuous
    virulent
    visible
    visual
    vital
    vivacious
    vivid
    vocal
    vociferous
    voluble
    voluminous
    voluntary
    voluptuous
    voracious
    vulgar
    vulnerable
    wan
    wanton
    wary
    warm
    wasteful
    watchful
    wayward
    weak
    weary
    week
    weird
    wester
    wet
    whimsical
    wholehearted
    whol
    wicked
    wide
    wife
    wiggly
    wild
    wilful
    willful
    willing
    winsome
    wise
    wishful
    wistful
    witless
    witty
    witting
    wobble
    woeful
    woman
    wonderful
    wondrous
    wooden
    wool
    wooly
    world
    worthy
    wrathful
    wretched
    wrigg
    wrink
    wrongful
    wrongheaded
    wrong
    wry
    year
    youthful
    zealous
    zestful
  )

  @animals ~w(
    Aardvark
    Albatross
    Alligator
    Alpaca
    Ant
    Anteater
    Antelope
    Ape
    Armadillo
    Ass
    Baboon
    Badger
    Barracuda
    Bat
    Bear
    Beaver
    Bee
    Bison
    Boar
    Buffalo
    Galago
    Butterfly
    Camel
    Caribou
    Cat
    Caterpillar
    Cattle
    Chamois
    Cheetah
    Chicken
    Chimpanzee
    Chinchilla
    Chough
    Clam
    Cobra
    Cockroach
    Cod
    Cormorant
    Coyote
    Crable
    Crane
    Crocodile
    Crow
    Curlew
    Deer
    Dinosaur
    Dog
    Dogfish
    Dolphin
    Donkey
    Dotterel
    Dove
    Dragonf
    Duck
    Dugong
    Dunlin
    Eagle
    Echidna
    Eel
    Eland
    Elephant
    ElephantSeal
    Elk
    Emu
    Falcon
    Ferret
    Finch
    Fish
    Flamingo
    Fly
    Fox
    Frog
    Gaur
    Gazelle
    Gerbil
    GiantPanda
    Giraffe
    Gnat
    Gnu
    Goat
    Goose
    Goldfinch
    Goldfish
    Gorilla
    Goshawk
    Grasshopper
    Grouse
    Guanaco
    GuineaFowl
    GuineaPig
    Gull
    Hamster
    Hare
    Hawk
    Hedgehog
    Heron
    Herring
    Hippopotamus
    Hornet
    Horse
    Human
    Hummingbird
    Hyena
    Jackal
    Jaguar
    Jay
    Jellyfish
    Kangaroo
    Koala
    KomodoDragon
    Kouprey
    Kudu
    Lapwing
    Lark
    Lemur
    Leopard
    Lion
    Llama
    Lobster
    Locust
    Loris
    Louse
    Lyrebird
    Magpie
    Mallard
    Manatee
    Marten
    Meerkat
    Mink
    Mole
    Monkey
    Moose
    Mouse
    Mosquito
    Mule
    Narwhal
    Newt
    Nightingale
    Octopus
    Okapy
    Opossum
    Oryx
    Ostrich
    Otter
    Owl
    Ox
    Oyster
    Panther
    Parrot
    Partridge
    Peafowl
    Pelican
    Penguin
    Pheasant
    Pig
    Pigeon
    Pony
    Porcupine
    Porpoise
    PrairieDog
    Quail
    Quelea
    Rabbit
    Raccoon
    Rail
    Ram
    Rat
    Raven
    Reddeer
    Redpanda
    Reindeer
    Rhinoceros
    Rook
    Ruff
    Salamander
    Salmon
    SandDollar
    Sandpiper
    Sardine
    Scorpion
    Sealion
    SeaUrchin
    Seahorse
    Seal
    Shark
    Sheep
    Shrew
    Shrimp
    Skunk
    Snail
    Snake
    Spider
    Squid
    Squirrel
    Starling
    Stingray
    Stinkbug
    Stork
    Swallow
    Swan
    Tapir
    Tarsier
    Termite
    Tiger
    Toad
    Trout
    Turkey
    Turtle
    Vicuña
    Viper
    Vulture
    Wallaby
    Walrus
    Wasp
    WaterBuffalo
    Weasel
    Whale
    Wolf
    Wolverine
    Wombat
    Woodcock
    Woodpecker
    Worm
    Wren
    Yak
    Zebra
  )

  alias BrutalChat.Hash

  def random_username(opts \\ []) do
    exclude = Keyword.get(opts, :exclude, [])

    adjective = Enum.random(@adjectives)
    animal = Enum.random(@animals)
    username = adjective <> animal

    if Enum.member?(exclude, username) do
      random_username(opts)
    else
      username
    end
  end

  @adj_salt 194_053_823_522
  @anm_salt 116_174_203_481
  def hash_username(key) do
    adjective = Enum.at(@adjectives, Integer.mod(Hash.fnv(key, @adj_salt), Enum.count(@adjectives)))
    animal = Enum.at(@animals, Integer.mod(Hash.fnv(key, @anm_salt), Enum.count(@animals)))
    adjective <> animal
  end

  @max_offset 1_000_000_000_000
  def new_username(key) do
    offset = :rand.uniform(@max_offset)
    {offset, hash_username("#{key}:#{offset}")}
  end

  def find_offset(key, adjective, animal) when adjective in @adjectives and animal in @animals do
    find_offset(key, adjective, animal, 0)
  end

  defp find_offset(key, adj, anm, offset) do
    hash_key = "#{key}:#{offset}"
    adjective = Enum.at(@adjectives, Integer.mod(Hash.fnv(hash_key, @adj_salt), Enum.count(@adjectives)))
    animal = Enum.at(@animals, Integer.mod(Hash.fnv(hash_key, @anm_salt), Enum.count(@animals)))

    if {adjective, animal} != {adj, anm} do
      find_offset(key, adj, anm, offset + 1)
    else
      offset
    end
  end

  def find_salts(key, adj, anm) do
    find_salts(key, adj, anm, @adj_salt, @anm_salt)
  end

  defp find_salts(key, adj, anm, adj_salt, anm_salt) do
    adjective = Enum.at(@adjectives, Integer.mod(Hash.fnv(key, adj_salt), Enum.count(@adjectives)))
    animal = Enum.at(@animals, Integer.mod(Hash.fnv(key, anm_salt), Enum.count(@animals)))

    cond do
      adjective != adj -> find_salts(key, adj, anm, adj_salt + 1, anm_salt)
      animal != anm -> find_salts(key, adj, anm, adj_salt, anm_salt + 1)
      true -> {adj_salt, anm_salt}
    end
  end
end
