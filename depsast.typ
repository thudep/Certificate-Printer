#set page(paper: "a4",flipped: true, margin: (x: 0em,y:0em),background: image("img/bg.svg"))

#let tsinghua_purple=rgb(106,8,116)

#set text(tracking: 1.5pt)

#set underline(offset: 4pt)

#place(center,dy:12em, text(font: "Source Han Serif", lang: "zh", region: "cn",[*工作证明*], size: 40pt,fill:tsinghua_purple))

#place(left,dy:19em,dx:14%, text(font: "Source Han Serif", lang: "zh", region: "cn",strong(underline[#include "name.typ"]), size: 28pt))

#place(left,dy:19em,dx:26%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*同学*], size: 24pt, fill:tsinghua_purple))

#place(center,dy:24em,dx:-20%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*你在*], size: 22pt,fill:tsinghua_purple))

#place(center,dy:24em, text(font: "Source Han Serif", lang: "zh", region: "cn",strong(underline[
  第
  #include "title.typ"
  届工物科协]), size: 22pt))

#place(center,dy:24em,dx:21%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*中担任*], size: 22pt,fill:tsinghua_purple))

#place(center,dy:28em, text(font: "Source Han Serif", lang: "zh", region: "cn",strong(underline[#include "content.typ"]), size: 28pt))

#place(left,dy:32em,dx:14%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*特此证明*], size: 22pt,fill:tsinghua_purple))

#place(left,dy:39em,dx:66%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*清华大学工物科协*], size: 20pt,fill:tsinghua_purple))

#place(left,dy:42em,dx:66%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*#datetime.display(datetime.today(), "[year]年[month]月[day]日")*], size: 20pt,fill:tsinghua_purple))

#place(center,dy:35em,dx:-30%, image("img/dep.png",width: 9em))

#place(center,dy:35em,dx:-18%, image("img/depsast.png",width: 9em))

#place(left,dy:47em,dx:14%, text(font: "Source Han Serif", lang: "zh", region: "cn",[*证书校验码*], size: 14pt,fill:tsinghua_purple))

// see https://github.com/typst/typst/issues/2196#issuecomment-1728135476
#let try_to_string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(try_to_string).join("")
  } else if content.has("body") {
    try_to_string(content.body)
  } else if content == [ ] {
    " "
  }
}

#place(left,dy:47em,dx:24%, text(raw(try_to_string([#include "fingerprint.typ"])), size: 16pt, fill:tsinghua_purple))

