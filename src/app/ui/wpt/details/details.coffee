import { RunThisTest } from './stats/run-this-test.coffee'
import { TestStatus } from './stats/status.coffee'
import { OtherBrowserResults } from './stats/other-browser-results.coffee'
import { SubtestListing } from './subtest-listing.coffee'
import { StatusMap } from '../../../utils/status.coffee'
import { wptFyiResultsUrl } from '../../../utils/fyi.coffee'
import { Throbber } from '../../throbber.coffee'
import { useState, useEffect } from 'preact/hooks'

export Details = ({ browser, entry, thisPath }) ->
  [data, setData] = useState(null)

  useEffect((->
    do ->
      url = await wptFyiResultsUrl(browser, thisPath)
      response = await fetch(url)
      response = await response.json()

      setData(response)
  ), [])

  if data == null
    return <div class='TestDetails'><Throbber /></div>

  map = StatusMap[entry.status]
  <div class='TestDetails'>
    <div class='overview'>
      <TestStatus {...{path: thisPath, map, data, entry}} />
      <OtherBrowserResults path={thisPath} />
      <RunThisTest path={thisPath} />
    </div>

    {
      if data.message
        <div class='message'>
          <span class='text-muted'><b>message</b></span>
          <pre>{data.message}</pre>
        </div>
    }

    {
      if data.subtests.length
        <SubtestListing subtests={data.subtests} />
    }
  </div>
