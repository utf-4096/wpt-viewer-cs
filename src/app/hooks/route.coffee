import { useEffect, useState } from "preact/hooks"

getLocation = ->
  window.location.hash.replace(/^#/, '')

export useRoute = (defaultLocation) ->
  [route, setRoute] = useState(getLocation() or defaultLocation)

  if getLocation() != route
    window.location.hash = '#' + route

  useEffect((->
    handleChange = ->
      setRoute(getLocation())

    window.addEventListener('hashchange', handleChange)

    return ->
      window.removeEventListener('hashchange', handleChange)
  ), [])

  return [route, setRoute]
