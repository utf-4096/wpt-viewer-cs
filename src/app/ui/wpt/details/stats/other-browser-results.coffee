import { TestIcon } from "../../../test-icon.coffee"
import { computeHistoryTestStatus } from "../../../../utils/fyi.coffee"
import { Throbber } from "../../../throbber.coffee"
import { useState, useEffect } from "preact/hooks"
import { StatusMap } from "../../../../utils/status.coffee"
import { Stat } from '../stat.coffee'

###
  Shows a single browser result
###
Result = ({ name, result }) ->
  status = computeHistoryTestStatus(result)
  map = StatusMap[status]
  date = new Date(result[''][0].date)
  dateString = date.toLocaleDateString()
  title = "test #{map.label.toUpperCase()} by #{name} on #{dateString}"

  <div key={name} class='result' title={title}>
    <TestIcon map={map} withTitle={false} />
    <span class='name'>{name}</span>
  </div>

###
  Displays the test results of other major web browsers
###
export OtherBrowserResults = ({ path }) ->
  [results, setResults] = useState(null)

  useEffect((->
    body = JSON.stringify(test_name: '/' + decodeURIComponent(path))

    response = await fetch('https://wpt.fyi/api/history', {
      method: 'POST',
      body: body
    })

    response = await response.json()
    response = response.results

    setResults(response)
  ), [])

  content = do ->
    if not results?
      return <Throbber />

    if Object.keys(results).length == 0
      return <span>no data :(</span>

    <ul>{
      for name, result of results
        <Result name={name} result={result} />
    }</ul>

  <Stat name='other browsers' class='OtherBrowserResults'>
    {content}
  </Stat>
