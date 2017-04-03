#lang racket

(module html-example racket
  (require net/url)
  (require html)

  (define myurl (string->url "https://www.wunderground.com/q/zmw:01850.1.99999"))
  (define myport (get-pure-port myurl))
  ;;(read-html myport)
  ;;(display-pure-port myport)




  (define in (open-input-file "index.html"))
 
  ; Some of the symbols in html and xml conflict with
  ; each other and with racket/base language, so we prefix
  ; to avoid namespace conflict.
  (require (prefix-in h: html)
           (prefix-in x: xml))
 
  (define an-html
    (h:read-xhtml
     (open-input-string
      (string-append (port->string in)))))
       ;;"<html><head><title>Sample Title</title></head><body bgcolor='white'><h1>HEADER</h1><p>Hello world!</p><p>This is a paragraph.</p></body></html>"))))
 
  ; extract-pcdata: html-content/c -> (listof string)
  ; Pulls out the pcdata strings from some-content.
  (define (extract-pcdata some-content)
    (cond [(x:pcdata? some-content)
           (list (x:pcdata-string some-content))]
          [(x:entity? some-content)
           (list)]
          [else
           (extract-pcdata-from-element some-content)]))
 
  ; extract-pcdata-from-element: html-element -> (listof string)
  ; Pulls out the pcdata strings from an-html-element.
  (define (extract-pcdata-from-element an-html-element)
    (match an-html-element
      [(struct h:html-full (attributes content))
       (apply append (map extract-pcdata content))]
 
      [(struct h:html-element (attributes))
       '()]))
  
  (close-input-port in)
  (printf "~s\n" (extract-pcdata an-html)))
 
(require 'html-example)
