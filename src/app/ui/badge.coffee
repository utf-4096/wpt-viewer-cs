import { Icon } from './icon.coffee'

export Badge = ({
  state: [checked, setChecked] = [],
  label,
  icon,
  hue = 0,
  saturation = 1,
  clickable = true,
  noPush = false,
}) ->
  class_ = 'Badge Button '
  if checked
    class_ += ' active'

  <div
    class={[class_, 'not-clickable' if not clickable, 'no-push' if noPush].join(' ')}
    onClick={(-> setChecked(not checked)) if clickable}
    style={'--hue': hue, '--saturation': saturation}
  >
    <Icon name={icon} />
    {
      if label
        <span>{label}</span>
    }
  </div>
