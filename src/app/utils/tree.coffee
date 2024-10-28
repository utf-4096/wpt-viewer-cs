export followDeep = (obj, path) ->
  head = obj

  for level in path
    if not head[level]
      return

    head = head[level]

  return head

export setDeep = (obj, path, value) ->
  head = obj

  for level in path[...-1]
    if head[level]
      head = head[level]
      continue

    head = head[level] = Object.create(null)

  head[path.at(-1)] = value
