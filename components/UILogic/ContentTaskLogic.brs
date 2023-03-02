sub RunContentTask()
  m.contentTask = CreateObject("roSGNode", "MainLoaderTask") ' create task for feed retrieving
  ' observe content so we know when content feed is parsed
  m.contentTask.ObserveField("content", "OnMainContentLoaded")
  m.contentTask.control = "run" ' GetContent(see MainContentTask.brs) method is executed
  m.loadingIndicator.visible = true ' show loading indicator while content is loading
end sub

sub OnMainContentLoaded() ' invoked when the content feed is finished being parsed
  m.GridScreen.SetFocus(true) ' set focus to GridScreen
  m.loadingIndicator.visible = false
  m.GridScreen.content = m.contentTask.content ' populate GridScreen with content
end sub
