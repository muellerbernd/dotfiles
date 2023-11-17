function! neoformat#formatters#sh#enabled() abort
    return ['beautysh', '{{ other formatter name for filetype }}']
endfunction

function! neoformat#formatters#sh#beautysh() abort
    return {
        \ 'exe': 'beautysh',
        \ }
endfunction

" function! neoformat#formatters#sh#{{ other formatter name }}() abort
"   return {'exe': {{ other formatter name }}
" endfunction
