sub Init()
  m.titleLabel = m.top.FindNode("titleLabel")
  m.descriptionLabel = m.top.FindNode("descriptionLabel")

  m.rowList = m.top.FindNode("rowList")
  m.rowList.SetFocus(true)
  m.rowList.ObserveField("rowItemFocused", "OnItemFocused")
end sub

sub OnItemFocused()
  focusedIndex = m.rowList.rowItemFocused ' get position of focused item
  ' rowItemFocused is 2-elements array - first el is row index, second el is item index in that row

  row = m.rowList.content.GetChild(focusedIndex[0]) ' get the row
  item = row.GetChild(focusedIndex[1]) ' get the item in the row

  m.titleLabel.text = item.title
  m.descriptionLabel.text = item.description

  ' adding length of playback to the title if item length field was populated
  if item.length <> invalid
    m.titleLabel.text += " | " + getTime(item.length)
  end if
end sub

function getTime(length as integer) as string
  minutes = (length \ 60).ToStr()
  seconds = length mod 60
  if seconds < 10
    seconds = "0" + seconds.ToStr()
  else
    seconds = seconds.ToStr()
  end if
  return minutes + ":" + seconds
end function
