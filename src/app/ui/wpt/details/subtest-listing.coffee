import { TestIcon } from '../../test-icon.coffee'
import { Badge } from '../../badge.coffee'
import { StatusMap, longStatusToShortStatus } from '../../../utils/status.coffee'
import { useState } from 'preact/hooks'

export SubtestListing = ({ subtests }) ->
  allStatuses = Array.from(new Set(subtest.status for subtest in subtests)).sort()
  [onlyStatus, setOnlyStatus] = useState(null)

  setNewStatus = (status) ->
    if status == onlyStatus
      setOnlyStatus(null)
    else
      setOnlyStatus(status)

  hasMessage = subtests.some((test) -> test.message)

  if onlyStatus != null
    subtests = subtests.filter((test) -> test.status == onlyStatus)

  <div class='subtest-listing'>
    <div class='title'>
      <span class='text-muted'><b>subtests</b></span>

      {<div class='filters badgeset'>{
          for status from allStatuses then do (status) ->
            map = StatusMap[longStatusToShortStatus status]
            state = [
              onlyStatus == null or onlyStatus == status,
              -> setNewStatus(status)
            ]

            <Badge
              state={state}
              icon={map.icon}
              hue={map.hue}
              saturation={map.saturation}
              label={map.label}
              noPush
            />
      }</div> if allStatuses.length != 1}
    </div>

    <table class={'has-message' if hasMessage}>
      {
        if hasMessage
          <thead>
          <tr>
            <th></th>
            <th>Name</th>
            <th>Message</th>
          </tr>
        </thead>
      }

      <tbody>
        {
          for subtest in subtests
            map = StatusMap[longStatusToShortStatus(subtest.status)]

            <tr key={subtest.name} class='subtest'>
              <td class='status' title={map.label}>
                <TestIcon map={map} />
              </td>

              <td class='name'>{subtest.name}</td>
              {
                if hasMessage
                  <td class='message'>{subtest.message}</td>
              }
            </tr>
        }
      </tbody>
    </table>
  </div>
