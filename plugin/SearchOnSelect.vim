if exists('s:loaded') || !((exists('g:SearchOnSelect_active') && g:SearchOnSelect_active))
	finish
endif
let s:loaded = 1

func SearchOnSelect#get_selected_text()
	let tmp = @"
	normal! gvy
	normal! gv
	let [tmp, @"] = [@", tmp]
	return tmp
endfunc

func SearchOnSelect#plain_text_pattern(s)
	return substitute(substitute('\V'.escape(a:s, '\'), '\n', '\\n', 'g'), '\t', '\\t', 'g')
endfunc

func SearchOnSelect#get_search_pat()
	return SearchOnSelect#plain_text_pattern(SearchOnSelect#get_selected_text())
endfunc

if g:SearchOnSelect_active == 1
	vnoremap n :<c-u>let @/=SearchOnSelect#get_search_pat()<cr><esc>nzz
	vnoremap <s-n> :<c-u>let @/=SearchOnSelect#get_search_pat()<cr><esc><s-n><s-n>zz
elseif g:SearchOnSelect_active == 2
	vnoremap n :<c-u>let @/=SearchOnSelect#get_search_pat()<cr><esc><s-n>zz
	vnoremap <s-n> :<c-u>let @/=SearchOnSelect#get_search_pat()<cr><esc><s-n>zz
elseif g:SearchOnSelect_active == 3
	vnoremap * :<c-u>let @/=SearchOnSelect#get_search_pat()<cr><esc><s-n>zz
endif

