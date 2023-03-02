' Channel's main entry point

sub Main()
    ' creates the screen and main scene, shows the scene and listens for scene's events
    ShowChannelRSGScreen()
end sub

sub ShowChannelRSGScreen()
    ' The roSGScreen object is a SceneGraph canvas that displays the contents of a Scene
    screen = CreateObject("roSGScreen")

    ' message port is the place where events are sent to the
    ' we're using m. to make it accessible to the whole MainScene component
    m.port = CreateObject("roMessagePort")

    ' sets the message port which will be used for events from the screen
    screen.SetMessagePort(m.port)

    ' adds the main scene to the screen
    scene = screen.CreateScene("MainScene")

    ' Init
    screen.Show()

    ' event loop
    while(true)
        ' waiting for events from screen
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed then return
        end if
    end while
end sub
