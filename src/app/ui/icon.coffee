# icons by clarity.design - (c) 2016-2021 VMware, Inc
# licensed under MIT
# https://github.com/vmware-clarity/core

import { memo } from 'preact/compat'
import search from '../../assets/search.svg?react'
import fire from '../../assets/fire.svg?react'
import check from '../../assets/check.svg?react'
import hourglass from '../../assets/hourglass.svg?react'
import times from '../../assets/times.svg?react'
import arrowUp from '../../assets/arrow-up.svg?react'
import arrowRight from '../../assets/arrow-right.svg?react'
import folder from '../../assets/folder.svg?react'
import chevronRight from '../../assets/chevron-right.svg?react'
import skip from '../../assets/skip.svg?react'
import error from '../../assets/error.svg?react'
import power from '../../assets/power.svg?react'
import warning from '../../assets/warning.svg?react'
import home from '../../assets/home.svg?react'
import halfStar from '../../assets/half-star.svg?react'
import block from '../../assets/block.svg?react'
import popOut from '../../assets/pop-out.svg?react'
import clipboard from '../../assets/clipboard.svg?react'
import code from '../../assets/code.svg?react'

ICONS = {
  search,
  fire,
  check,
  hourglass,
  times,
  folder,
  skip,
  error,
  power,
  warning,
  home,
  block,
  clipboard,
  code,

  'arrow-up': arrowUp,
  'arrow-right': arrowRight,
  'chevron-right': chevronRight,
  'half-star': halfStar,
  'pop-out': popOut,
}

export Icon = memo ({name, class: class_, ...rest}) ->
  X = ICONS[name]

  <div class={"Icon #{class_ or ''}"} {...rest}>
    <X />
  </div>
