:- module(start, [
              go/0
          ]).
/** <module>  server for I love my camel game
 *
 */

:- use_module(library(settings)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).

:- setting(port, integer,  8888, "Port to expose web interface on").

go :-
    setting(start:port, Port),
    http_server(http_dispatch, [port(Port)]).

:- http_handler('/', set_lang, []).

set_lang(_Request) :-
  %      http_parameters(Request,
  %                      [ lang(Lang, [])
  %                      ]),
  %      http_session_retractall(lang(_)),
  %      http_session_assert(lang(Lang)),
        reply_html_page(title('I Love My Camel'),
                        \camel_map).


:- http_handler(root(img), http_reply_from_files('img/', []), [prefix]).


camel_map -->
    html([
        p('here is a page'),
        canvas([height(400), width(600)], '')
    ]).
