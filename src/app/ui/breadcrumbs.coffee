import { Icon } from './icon.coffee'
import { Fragment } from 'preact'

Crumb = ({ path }) ->
  <a class='crumb' href="#/#{path.join('/')}">
    {path.at(-1)}
  </a>

export Breadcrumbs = ({ path }) ->
  crumbs = path.map (_, index) ->
    <Fragment key={index}>
      {if index != 0 then <Icon name='chevron-right'/>}
      <Crumb path={path[0 ... index + 1]} />
    </Fragment>

  <div class='Breadcrumbs'>
    <a class='crumb' href='#/'>
      <Icon name='home' />
    </a>

    {
      if path.length
        <Icon name='chevron-right'/>
    }

    {crumbs}
  </div>
