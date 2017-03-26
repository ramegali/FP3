## html-parsing library
**My name:** Raphael Megali

I built off of sample code as well as some of the things I did in FP1 to try my hand at some html-parsing.
The program takes the html file as an input file, reads it as a string, and outputs the different parts of the html file (head, body, elements, etc.) to the screen. 

## The project:
Our goal for this project is to find a way to display relevent current weather and time information on a webpage. We will try to scrape this info from weather underground's website. The code above gets the url provided, intiates a few different requests for it, and returns a pure port HTML connection corresponding to the body of the response.

**Code exerpt:**
```
(require net/url)
  (require html)

  (define myurl (string->url "https://www.wunderground.com/q/zmw:01850.1.99999"))
  (define myport (get-pure-port myurl)
```

After defining **in** as the input file with the html code, it is read in as a string by the program:
```
(define an-html
    (h:read-xhtml
     (open-input-string
      (string-append (port->string in)))))
```

**some-content** here corresonds to the **an-html** element created above. This code will parse through the extracted string to pull the information requested. In this current state, it just pulls the different html elements and displays them.
```
define (extract-pcdata some-content)
    (cond [(x:pcdata? some-content)
           (list (x:pcdata-string some-content))]
          [(x:entity? some-content)
           (list)]
          [else
           (extract-pcdata-from-element some-content)]))
 
  (define (extract-pcdata-from-element an-html-element)
    (match an-html-element
      [(struct h:html-full (attributes content))
       (apply append (map extract-pcdata content))]
```

I ran into issues trying to use weather underground's html file, so I used the one I wrote in FP1.
*Here's a screenshot of the resulting output:*

![alt tag](https://github.com/ramegali/FP1/blob/master/FP3_output.png)

The next step would be to get the necessary information from weather underground after getting the html info.

