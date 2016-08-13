" Make sure Julia tags are shown in tagbar
"  \ 'kinds'     : ['f:function']
let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : ['a:abstract', 'i:immutable', 't:type', 'f:function', 'm:macro']
    \ }

setlocal iskeyword+=\!
