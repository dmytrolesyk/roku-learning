sub InitScreenStack()
  m.screenStack = []
end sub

' take a node representing a new screen, adds it to the screen stack
' and displays it after hiding the current one
sub ShowScreen(node as object)
  prev = m.screenStack.Peek() ' take a current screen from the stack but don't delete it
  if prev <> invalid
    prev.visible = false ' hide current screen if it exists
  end if

  m.top.AppendChild(node)
  node.visible = true
  node.SetFocus(true)
  m.screenStack.Push(node) ' add new screen to the screen stack
end sub

sub CloseScreen(node as object)
  if node = invalid or (m.screenStack.Peek() <> invalid and m.screenStack.Peek().IsSameNode(node))
    last = m.screenStack.Pop() 'remove screen from screenStack
    last.visible = false ' hide screen
    m.top.RemoveChild(node) ' remove screen from scene

    ' take previous screen and make it visible
    prev = m.screenStack.Peek()
    if prev <> invalid
      prev.visible = true
      prev.SetFocus(true)
    end if
  end if
end sub
