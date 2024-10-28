import { TestIcon } from '../test-icon.coffee'
import { StatusMap } from '../../utils/status.coffee'
import { Progress } from '../progress.coffee'
import { WPTTree, Entry } from '../../WPTTree.coffee'
import { Icon } from '../icon.coffee'

FolderStat = ({ value, onlyStatuses }) ->
  stats = value[WPTTree.Meta]

  <div class='statuses'>
    {
      for key, map of StatusMap
        statusIsSelected = onlyStatuses.size == 0 or onlyStatuses.has(key)

        if stats? and statusIsSelected and stats[key] != 0
          <div class='status'>
            {<Icon name={map.icon} />}
            {stats[key]}
          </div>
    }
  </div>

export TreeViewEntry = ({ name, value, path, onlyStatuses }) ->
  isFolder = value not instanceof Entry

  if isFolder
    [passed, total] = value[WPTTree.MetaSubtest]
  else
    passed = value.passedTests
    total = value.totalTests

  map = StatusMap[value.status] if not isFolder
  hashUrl = "#/#{[...path, name].join('/')}"

  <tr>
    <td>
      <a href={hashUrl}>
        <div class='path'>
          {
            if isFolder
              <Icon name='folder' />
            else
              <TestIcon map={map} />
          }

          <span>{name}</span>

          {
            if isFolder
              <span class='item-count'>
                {Object.values(value).length} items
              </span>
          }
        </div>
      </a>
    </td>

    <td colspan={if total == 0 then 2 else 1}>
      <a href={hashUrl}>
        {
          if isFolder
            <FolderStat value={value} onlyStatuses={onlyStatuses} />
        }
      </a>
    </td>

    {<td style='width: 1%' class='completion'>
      <a href={hashUrl}>
        <Progress value={passed} max={total} reverse />
      </a>
    </td> if total != 0}
  </tr>
