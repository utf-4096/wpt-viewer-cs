Browsers =
  firefox:
    icon: 'https://wpt.fyi/static/firefox_64x64.png'

  'chrome-110':
    icon: 'https://wpt.fyi/static/chrome_64x64.png'

  edge:
    icon: 'https://wpt.fyi/static/edge_64x64.png'

  safari:
    icon: 'https://wpt.fyi/static/safari_64x64.png'

  ladybird:
    icon: 'https://wpt.fyi/static/ladybird_64x64.png'

export BrowserPicker = ({ value, onChange }) ->
  <div class='BrowserPicker'>
    <ul>{
      for key, browser of Browsers then do (key, browser) ->
        <li
          key={key}
          class={'selected' if value == key}
          onClick={-> onChange(key)}
        >
          <img class='icon' src={browser.icon} />
        </li>
    }</ul>
  </div>
