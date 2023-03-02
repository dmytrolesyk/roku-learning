' entry point of MainScene
' this function initializes variables referencing components in the xml file
' that variables can then be used throughout the brightscript file
sub Init()
  m.top.backgroundColor = "0x6fbb1"
  m.top.backgroundUri = "pkg:/images/background.jpeg"
  m.loadingIndicator = m.top.findNode("loadingIndicator") ' store loadingIndicator node to m
  InitScreenStack()
  ShowGridScreen()
  RunContentTask() ' retrieving content
end sub
