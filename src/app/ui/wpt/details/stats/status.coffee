import { Progress } from "../../../progress.coffee"
import { TestIcon } from "../../../test-icon.coffee"
import { Stat } from "../stat.coffee"

export TestStatus = ({ map, data, entry }) ->
  <Stat name='test status' class='Status'>
    <TestIcon map={map} />

    <div class='column'>
      <span>{map.label.toUpperCase()} in {data.duration / 1000}s</span>
      {
        if data.subtests.length != 0
          <Progress value={entry.passedTests} max={entry.totalTests} />
      }
    </div>
  </Stat>
