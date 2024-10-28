import { Details } from './details/details.coffee'
import { Entry } from '../../WPTTree.coffee'
import { TreeViewEntry } from './tree-view-entry.coffee'
import { Breadcrumbs } from '../breadcrumbs.coffee'

DirectoryListing = ({ tree, path, statuses }) ->
  keys = Object.keys tree
  keys.sort (a, b) -> a.localeCompare(b)
  keys.sort (a, b) ->
    if tree[a] instanceof Entry and tree[b] not instanceof Entry
      return 1
    else
      return -1

  entries = keys.map (name) ->
    value = tree[name]

    <TreeViewEntry key={name} onlyStatuses={statuses} {...{name, value, path}} />

  <table class='directory-listing'>
    <thead>
      <tr>
        <th></th>
        <th></th>
        <th></th>
      </tr>
    </thead>

    <tbody>
      {entries}
    </tbody>
  </table>

export TreeView = ({ browser, path, tree, statuses, search }) ->
  built = tree.navigate({ statuses, search }, path)

  thisPath = path.join '/'
  thisPath = thisPath.replace /\?.*/, (v) -> encodeURIComponent v

  <div class='WPTTreeView'>
    <div class='wpt-breadcrumbs'>
      <span class='text-muted'>navigating:</span>
      <Breadcrumbs path={path} />
    </div>

    {
      if built
        if built instanceof Entry
          <Details browser={browser} entry={built} thisPath={thisPath} />
        else
          <DirectoryListing tree={built} {...{path, statuses}} />
      else
        <span>No such test</span>
    }
  </div>
