let s:magentagray = [ '#66596a', 59 ]
let s:magentadarkgray = [ '#4f4751',  59]
let s:magentadarkestgray = [ '#38303a',  59]
let s:light = ['#f3f4e9', 230 ]
let s:lightgray = ['#d8ced9', 188 ]
let s:magentamedgray = ['#766678', 96 ]
let s:yellow = [ '#ecf583', 228 ]
let s:orange = [ '#8b3313', 94 ]
let s:red = [ '#ff3661', 203 ]
let s:darkred = [ '#4C010B', 52 ]
let s:hotpink = [ '#e90afd', 165 ]
let s:lightpink = [ '#fcceed', 225 ]
let s:magentaneutral = [ '#db8efe', 216 ]
let s:magentadark = [ '#39165a', 216 ]
let s:maglight1 = ['#bfadc3', 146]
let s:magmed1 = ['#5e4f5f', 59] 
let s:maglight2 = ['#8a7e8d', 102]
let s:magmed2 = ['#5e4f5f', 59] 
let s:magdark3 = ['#413a42', 59]
let s:magmed3 = ['#887989', 59]
let s:blue = [ '#8ac6f2', 117 ]
let s:cyan = s:blue
let s:cyanfaded = [ '#859eb3', 109 ]
let s:green = [ '#8FF31f', 118 ]
let s:darkgreen = [ '#2e4c01', 58 ]
let s:greenfaded = [ '#7eb18d', 108 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:magentadark, s:magentaneutral ], [ s:lightgray, s:magentagray ] ]
let s:p.normal.right = [ [ s:magmed1, s:maglight1 ], [ s:maglight1, s:magentagray ] ]
let s:p.inactive.right = [ [ s:magmed2, s:maglight2 ], [ s:magmed3, s:magdark3 ] ]
let s:p.inactive.left =  [ [ s:maglight2, s:magdark3 ], [ s:magmed2, s:maglight2 ] ]
let s:p.insert.left = [ [ s:darkgreen, s:green ], [ s:lightgray, s:magentagray ] ]
let s:p.replace.left = [ [ s:darkred, s:red ], [ s:lightgray, s:magentagray ] ]
let s:p.visual.left = [ [ s:hotpink, s:lightpink ], [ s:lightgray, s:magentagray ] ]
let s:p.normal.middle = [ [ s:lightgray, s:magentadarkgray ] ]
let s:p.inactive.middle = [ [ s:magentamedgray, s:magentadarkestgray ] ]
let s:p.tabline.left = [ [ s:maglight2, s:magdark3 ]  ]
let s:p.tabline.tabsel = [ [ s:magentaneutral, s:magentadark ] ]
let s:p.tabline.middle = [ [ s:lightgray, s:magentadarkgray ] ]
let s:p.tabline.right = [ [ s:magmed1, s:maglight2 ] ]
let s:p.normal.error = [ [ s:darkred, s:red ] ]
let s:p.normal.warning = [ [ s:orange, s:yellow ] ]

let g:lightline#colorscheme#pufflehuff#palette = lightline#colorscheme#flatten(s:p)
