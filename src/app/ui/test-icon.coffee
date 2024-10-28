import { statusMapToStyle } from "../utils/status.coffee"
import { Icon } from "./icon.coffee"

export TestIcon = ({ map, withTitle = true }) ->
  <Icon
    class='TestIcon'
    style={statusMapToStyle(map)}
    name={map.icon}
    title={map.label if withTitle}
  />
