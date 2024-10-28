import { Button } from "../../../button.coffee"
import { useState } from "preact/hooks"
import { Stat } from "../stat.coffee"

CopyInput = ({ path }) ->
  [hasCopied, setHasCopied] = useState(false)

  liveUrl = "wpt.live/#{decodeURIComponent(path)}"
  fullLiveUrl = "https://#{liveUrl}"
  sourceUrl = "https://github.com/web-platform-tests/wpt/blob/master/#{path}"

  copyToClipboard = ->
    type = 'text/plain'
    blob = new Blob([fullLiveUrl], { type })
    data = [new ClipboardItem({ [type]: blob })]
    await window.navigator.clipboard.write(data)

    setHasCopied(true)
    setTimeout((-> setHasCopied(false)), 1000)

  <div class='CopyInput'>
    <input type='text' value={liveUrl} readonly />
    <div class='buttons'>
      <Button
        icon='pop-out'
        onClick={-> window.open(fullLiveUrl)}
        label='open'
        noPush
      />

      <Button
        icon={if hasCopied then 'check' else 'clipboard'}
        onClick={copyToClipboard}
        label={if hasCopied then 'copied' else 'copy'}
        noPush
      />

      <Button
        icon='code'
        onClick={-> window.open(sourceUrl)}
        label='source'
        noPush
      />
    </div>
  </div>

export RunThisTest = ({ path }) ->
  <Stat name='run this test'>
    <CopyInput
      path={path}
      withOpen
    />
  </Stat>
