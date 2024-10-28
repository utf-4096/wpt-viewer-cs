export ErrorReporter = ({ error }) ->
  <div class='ErrorReporter'>
    <span class='title'>(x_x) an error has occured</span>
    <pre class='content'>{error.toString()}<br/>{error.stack}</pre>
  </div>
