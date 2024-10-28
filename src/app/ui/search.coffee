import { Icon } from './icon.coffee'

export default ({ placeholder, onChange, value, onSubmit, autoFocus }) ->
  submit = (e) ->
    e.preventDefault()
    onSubmit() if onSubmit?

  <form class='Search' onSubmit={submit}>
    <Icon name='search' />
    <input
      type='text'
      placeholder={placeholder}
      onChange={(e) -> onChange e.target.value}
      value={value}
      autoFocus={autoFocus}
    />
  </form>
