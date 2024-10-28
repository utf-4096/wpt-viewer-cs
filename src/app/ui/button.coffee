import { Icon } from './icon.coffee'

export Button = ({
  disabled = false,
  onClick,
  label,
  children,
  icon,
  noPush = false,
  ...rest,
}) ->
  children or= label

  <button
    class={['Button', 'no-push' if noPush, 'with-text' if children].join ' '}
    onClick={onClick}
    disabled={disabled}
    {...rest}
  >
    {<Icon name={icon} /> if icon}
    {<span>{children}</span> if children}
  </button>
