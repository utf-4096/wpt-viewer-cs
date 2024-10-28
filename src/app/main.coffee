import { useRoute } from './hooks/route.coffee'
import { StatusMap } from './utils/status.coffee'
import { ErrorReporter } from './ui/error-reporter.coffee'
import { Throbber } from './ui/throbber.coffee'
import { useState, useEffect, useErrorBoundary, useMemo } from 'preact/hooks'
import { Badge } from './ui/badge.coffee'
import Search from './ui/search.coffee'
import { render } from 'preact'
import { WPTTree } from './WPTTree.coffee'
import { TreeView } from './ui/wpt/tree-view.coffee'

browser = 'ladybird'

App = ->
  [statuses, setStatuses] = useState(new Set())
  [flatTree, setFlatTree] = useState(null)
  [error] = useErrorBoundary()
  [search, setSearch] = useState('')
  [route, setRoute] = useRoute('/')

  # reset search on navigation
  useEffect((-> setSearch('')), [route])

  # fetch the flat wpt result tree
  useEffect((->
    do ->
      flatTree = await fetch("https://wpt.fyi/api/results?product=#{browser}")
        .then (r) -> r.json()

      setFlatTree(flatTree)

    return null
  ), [browser])

  # only rebuild the tree on flat tree changes
  tree = useMemo((->
    new WPTTree(flatTree or {})
  ), [flatTree])

  # total fail/timeout/pass/etc stats
  counts = tree.statusCount()

  path = route.split('/').filter(Boolean)
  document.title = route

  toggleStatus = (name) ->
    if statuses.has(name)
      statuses.delete(name)
    else
      statuses.add(name)

    setStatuses new Set([...statuses])

  if error
    console.error 'Uncaught exception!', error

  # search + enter quick navigation
  navigateToFirstResult = ->
    firstResult = Object.keys(tree.navigate({search, statuses}, path))[0]
    newPath = [...path, firstResult]
    if not tree.navigate({search, statuses}, newPath)
      return

    setRoute('/' + newPath.join('/'))

  <div>
    <header>
      <a class='logo' href='#/' draggable={false}>
        wpt viewer
      </a>

      {
        if not flatTree
          <Throbber />
      }
    </header>

    <main>
      <Search
        placeholder='Type the name of a test or folder'
        value={search}
        onChange={(value) -> setSearch(value)}
        onSubmit={navigateToFirstResult}
        autoFocus
      />

      <div class='badges'>
        {
          for status, badge of StatusMap then do (status) ->
            state = [
              statuses.size == 0 or statuses.has(status),
              -> toggleStatus(status),
            ]

            <Badge
              icon={badge.icon}
              label="#{badge.label} #{counts[status]}"
              hue={badge.hue or 0}
              saturation={badge.saturation}
              state={state}
            />
        }
      </div>

      {<ErrorReporter error={error} /> if error}

      {
        if flatTree
          <TreeView {...{tree, statuses, search, path, browser}} />
      }
    </main>
  </div>

render(<App/>, document.getElementById('app'))
