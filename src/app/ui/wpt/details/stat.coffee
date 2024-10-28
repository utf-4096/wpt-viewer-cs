export Stat = ({ name, class: class_ = '', children }) ->
  <div class={'Stat ' + class_}>
    <span class='name'>{name}</span>

    <div class='content'>
      {children}
    </div>
  </div>
