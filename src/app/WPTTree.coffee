import { setDeep, followDeep } from './utils/tree.coffee'

export class Entry
  status: ''
  passedTests: 0
  totalTests: 0

  constructor: ({ @status, @passedTests, @totalTests } = {}) ->

export class WPTTree
  @StatusList: ['O', 'P', 'F', 'S', 'E', 'N', 'C', 'T', 'PF']
  @Meta: Symbol('WPTTree.Meta')
  @MetaSubtest: Symbol('WPTTree.MetaSubtest')

  @emptyStatusMap: ->
    Object.fromEntries([k, 0] for k in @StatusList)

  @recomputeTestEntry: (entry) ->
    status = entry.s
    [passedTests, totalTests] = entry.c

    if status == 'O'
      # PASS if v == max
      if passedTests == totalTests
        status = 'P'
      # FAIL if v == 0
      else if passedTests == 0
        status = 'F'

    return {s: status, c: [passedTests, totalTests]}

  @populateMetadata: (parent) ->
    stats = @emptyStatusMap()
    passedTests = 0
    totalTests = 0

    for key, value of parent
      if value instanceof Entry
        # entry
        totalTests += value.totalTests or 1
        if value.status in ['O', 'P']
          if value.status == 'P' and value.totalTests == 0
            passedTests += 1
            totalTests += 1
          else
            passedTests += value.passedTests

        stats[value.status] += 1
      else
        # directory
        @populateMetadata(value)

        for sk of value[@Meta]
          stats[sk] += value[@Meta][sk]

        passedTests += value[@MetaSubtest][0]
        totalTests += value[@MetaSubtest][1]

      parent[@Meta] = stats
      parent[@MetaSubtest] = [passedTests, totalTests]

  constructor: (flat) ->
    start = window.performance.now()

    # create the tree from the flat map
    tree = Object.create(null)
    for key, value of flat
      # remove leading slash
      key = key.slice 1

      # some status values are wrong, we need to fix them
      value = @constructor.recomputeTestEntry(value)
      status = value.s
      [passedTests, totalTests] = value.c

      # makes things easier to work with
      entry = new Entry({status, passedTests, totalTests})

      # created a nested key
      path = key.split('/')
      setDeep(tree, path, entry)

    # populate metadata
    @constructor.populateMetadata(tree)

    @tree = tree

    taken = (window.performance.now() - start) / 1000
    numEntries = Object.keys(flat).length
    if numEntries != 0
      console.groupCollapsed('WPT test tree build')
      console.log("#{numEntries} entries")
      console.log("took #{taken}s")
      console.log("#{Math.floor(numEntries / taken)} entries/s")
      console.groupEnd()

  statusCount: ->
    @tree[@constructor.Meta] or @constructor.emptyStatusMap()

  navigate: ({ search = '', statuses = [] } = {}, path) ->
    statuses = Array.from(statuses)
    branch = followDeep(@tree, path)

    if not branch
      return null

    if branch instanceof Entry
      return branch

    unless branch[@constructor.Meta] or branch[@constructor.MetaSubtest]
      return null

    filters = []

    if statuses.length != 0
      filters.push (key, value) =>
        if value instanceof Entry
          return statuses.includes(value.status)
        else
          stats = value[@constructor.Meta]
          return statuses.some (status) -> stats[status] > 0

    if search = search?.trim()?.toLowerCase()
      filters.push (key, value) ->
        key.toLowerCase().includes(search)

    branch =
      Object.entries(branch)
      .filter ([key, value]) =>
        filters.every((fn) -> fn(key, value))

    return Object.fromEntries(branch)
