local highlight_author_filter = {
  Para = function(el)
    for k,_ in ipairs(el.content) do
          if el.content[k].t == "Str" and el.content[k].text == "Dunnett,"
          and el.content[k+1].t == "Space"
          and el.content[k+2].t == "Str" and el.content[k+2].text:find("^S") then
              local _,e = el.content[k+2].text:find("^S")
              local rest = el.content[k+2].text:sub(e+1) 
              el.content[k] = pandoc.Strong { pandoc.Str("Dunnett, S") }
              el.content[k+1] = pandoc.Str(rest)
              table.remove(el.content, k+2) 
          end
    end
    return el
  end
}

function Div (div)
  if div.identifier:find("^ref-") then
    return pandoc.walk_block(div, highlight_author_filter) 
  end
  return nil
end