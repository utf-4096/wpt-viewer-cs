formatter = new Intl.NumberFormat()

export Progress = ({ value, max }) ->
  if value == 0 and max == 0
    max = 1

  <div
    class={['Progress', 'full' if value == max].join(' ')}
    style={'--status-color': "hsl(#{value / max * 120}, 40%, 45%)"}
  >
    <span>{formatter.format(value)}/{formatter.format(max)}</span>
    <div class='bar'>
      <div class='inner' style={width: "#{value/max * 100}%"} />
    </div>
  </div>
