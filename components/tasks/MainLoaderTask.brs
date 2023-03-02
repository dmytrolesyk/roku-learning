sub Init()
  ' set the name of the function in the Task node component to be executed when the state field changed to RUN
  ' in our case this method executed after the following cmd: m.contentTask.control = "run" (see init method in MainScene)
  m.top.functionName = "GetContent"
end sub

sub GetContent()
  ' request the content feed from the API
  xfer = CreateObject("roURLTransfer")
  xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  xfer.SetURL("http://192.168.0.174:8888/videos")
  rsp = xfer.GetToString()
  rows = []

  ' parse the feed and build a tree of ContentNodes to populate the GridView
  json = ParseJson(rsp)
  if json <> invalid
    for each category in json
      value = json.Lookup(category)
      row = {}
      row.title = category
      row.children = []
      for each item in value ' parse items and push them to row
        video = GetVideoData(item)
        row.children.Push(video)
      end for
      rows.Push(row)
    end for
    ' set up a root ContentNode to represent rowList on the GridScreen
    contentNode = CreateObject("roSGNode", "ContentNode")
    contentNode.Update({
      children: rows
    }, true)
    ' populate content field with root content node.
    ' Observer(see OnMainContentLoaded in MainScene.brs) is invoked at that moment
    m.top.content = contentNode
  end if
end sub

function GetVideoData(video as object) as object
  item = {}
  ' populate some standard content metadata fields to be displayed on the GridScreen
  ' https://developer.roku.com/docs/developer-program/getting-started/architecture/content-metadata.md
  if video.longDescription <> invalid
    item.description = video.longDescription
  else
    item.description = video.shortDescription
  end if
  item.hdPosterURL = video.thumbnail
  item.title = video.title
  item.releaseDate = video.releaseDate
  item.id = video.id
  if video.content <> invalid
    ' populate length of content to be displayed on the GridScreen
    item.length = video.content.duration
  end if
  return item
end function
