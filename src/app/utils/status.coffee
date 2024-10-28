export longStatusToShortStatus = (long) ->
  switch long
    when 'OK' then 'O'
    when 'PASS' then 'P'
    when 'FAIL' then 'F'
    when 'SKIP' then 'S'
    when 'ERROR' then 'E'
    when 'NOTRUN' then 'N'
    when 'CRASH' then 'C'
    when 'TIMEOUT' then 'T'
    when 'PRECONDITION_FAILED' then 'PF'

export statusMapToStyle = (map) ->
  {
    '--hue': map.hue
    '--saturation': map.saturation or 1
  }

export StatusMap =
  F: {icon: 'times', label: 'fail', hue: 0 }
  C: {icon: 'fire', label: 'crash', hue: 0 }
  E: {icon: 'error', label: 'error', hue: 40 }
  T: {icon: 'hourglass', label: 'timeout', hue: 40 }
  O: {icon: 'half-star', label: 'ok', hue: 60, saturation: 0.7 }
  P: {icon: 'check', label: 'pass', hue: 110 }
  S: {icon: 'skip', label: 'skipped', saturation: 0 }
  N: {icon: 'power', label: 'not run', saturation: 0 }
  PF: {icon: 'warning', label: 'precondition failed', saturation: 0 }
