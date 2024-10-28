import { longStatusToShortStatus } from "./status.coffee"

urlPrefixCache = new Map()
getWptFyiResultsUrlPrefix = (browser) ->
  if value = urlPrefixCache.get(browser)
    return value

  response = await fetch("https://wpt.fyi/api/runs?product=#{browser}")
  [response] = await response.json()

  value = response.results_url.replace(/-summary_v2\.json\.gz$/, '')
  urlPrefixCache.set(browser, value)

  return value

export wptFyiResultsUrl = (browser, suffix) ->
  (await getWptFyiResultsUrlPrefix(browser)) + '/' + suffix

export computeHistoryTestStatus = (subtest) ->
  longStatus = do ->
    ignoredStatuses = ['PASS', 'FAIL', 'NOTRUN', 'OK']
    rootTest = subtest[''].at(-1)

    # single test, leave as-is
    if Object.keys(subtest).length == 1
      return rootTest.status

    if rootTest.status not in ignoredStatuses
      return rootTest.status

    values = Object.values(subtest).slice(1).map((v) -> v.at(-1))
    values = values.map((v) ->
      if v.status == 'MISSING'
        v.status = 'NOTRUN'

      return v
    )

    # special statuses come first
    specialStatus = values.find((v) -> v.status not in ignoredStatuses)
    return specialStatus.status if specialStatus

    # only some tests have failed
    if (new Set(v.status for v in values)).size > 1
      return 'OK'

    # the only test status
    return values[0].status

  return longStatusToShortStatus(longStatus)
