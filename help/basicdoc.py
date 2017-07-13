#!/usr/bin/python

import os, traceback, sys, re

                  # from the 200 commonest words in English
COMMON_WORDS = ["and","but","can","will","should","the","you","was","are","they","one","his",
                 "have","this","from","some","what","out","other","were","then","all","there",
                 "where","word","how","said","each","she","which","way","about","many","then",
                 "them","would","like","these","her","thing","see","two","him","has","more",
                 "could","come","did","most","who","over","know","than","first","may","down",
                 "side","been","any","new","find","take","place","get","live","after","back",
                 "little","big","only","came","every","give","our","under","very","few","just",
                 "much","great","say","before","turn","because","same","differ","right","left",
                 "too","does","set","well","also","small","end","put","must","high","such","why",
                 "ask","change","went","kin","off","need","try","again","near","self",
                 # words that trial-an-error so need to be excluded
                 "don","sub","here",
                 # words common in computer documentation
                 "click","mouse","key","window","screen"]

class Writer(object):
    def __init__(self,debian=False):
        self.output = None
        self.section_name = None
        self.subsection_name = None
        self.subsubsection_name = None
        self.subsubsubsection_name = None
        self.index = None
        self.in_list = False
        self.in_pre = False
        self.debian = debian

    def open_output(self,fname):
        if self.debian:
            fname = 'build/'+fname
        return open(fname,"w")

    def make_key(self,name):
        return name.lower().strip().translate(None,"\"':;,.?\\|[]{}<>()*&%$@!`~\t").replace(" ","-")

    def parse_name(self,name):
        m = re.match("([a-z\/]+\.(png|jpg|jpeg)) (.+)",name)
        if m:
            title = m.group(3)
            f = m.group(1)
        else:
            f = None
            title = name
        return (title,f)

    def escape(self,s):
        for i, j in self.escapes():
            s = s.replace(i,j)
        return s

    def include(self,fname):
        with open(fname,"r") as fd:
            n = 0
            for line in fd.readlines():
                m = re.match(r"^\.([a-z]+) ?(.*)",line)
                if m:
                    param = m.group(2).strip()
                    cmd = m.group(1)
                    try:
                        getattr(self,cmd) (param)
                    except:
                        self.inline_error(fname,n,traceback.format_exc())
                elif self.output:
                    if self.in_pre:
                        self.output.write(line+"\n")
                    elif line.strip() == "":
                        self.end_list()
                        self.blank()
                    else:
                        self.output.write(self.escape(line))
                n += 1
            self.end_list()
           

    def inline_error(self,fname,line,text):
        sys.stderr.write("%s: %s %s\n" % (fname,line,text))
        if self.output:
            self.pre("")
            self.output.write("%s: %s %s\n" % (fname,line,text))
            self.end_pre()

    def end(self,line):
        getattr(self,"end_"+line) ()

    def section(self,line):
        self.title, self.titlefile = self.parse_name(line)
        self.key = self.make_key(self.title)
        self.section_name = self.key
        self.subsection_name = None
        self.subsubsection_name = None
        self.end_list()

    def subsection(self,line):
        self.title, self.titlefile = self.parse_name(line)
        self.key = self.make_key(self.title)
        self.subsection_name = self.key
        self.subsubsection_name = None
        self.end_list()

    def subsubsection(self,line):
        self.title, self.titlefile = self.parse_name(line)
        self.key = self.make_key(self.title)
        self.subsubsection_name = self.key
        self.end_list()

    def subsubsubsection(self,line):
        self.end_list()

    def paragraph(self,line):
        self.subsubsubsection(line)

    def link(self,line):
        m = re.match("([^ ]+) ?(.*)",line)
        if m:
            self.hyperlink2(m.group(1),m.group(2))
        else:
            self.hyperlink1(line)

    def item(self,line):
        if not self.in_list:
            self.in_list = True
            self.start_list()
        self.list_item(line)

    def end_list(self):
        if self.in_list:
            self.do_end_list()
            self.in_list = False

class LatexWriter(Writer):
    
    def __init__(self,debian):
        super(LatexWriter,self).__init__(debian)
        self.output = self.open_output("easygp.tex")
        with open("intro.tex","r") as intro:
            self.output.write(intro.read())

    def escapes(self):
        return [('\\', '\\\\'),('/','\\slash '),('$', '\\$'),('%', '\\%'),('&', ' and '),('<', '$<$'),('>', "$>$"),('_', '\\textunderscore ')]

    def include(self,line):
        self.output.write("\n\n\\texttt{[File %s]}\n\n" % self.escape(line))
        super(LatexWriter,self).include(line)

    def section(self,line):
        super(LatexWriter,self).section(line)
        self.output.write("\\chapter{%s}\n\\label{%s}\n" % (self.escape(self.title),self.key))

    def subsection(self,line):
        super(LatexWriter,self).subsection(line)
        self.output.write("\\clearpage\n\\section{%s}\n\\label{%s}\n" % (self.escape(self.title),self.key))

    def subsubsection(self,line):
        super(LatexWriter,self).subsubsection(line)
        self.output.write("\\subsection{%s}\n\\label{%s}\n" % (self.escape(self.title),self.key))
 
    def subsubsubsection(self,line):
        super(LatexWriter,self).subsubsubsection(line)
        self.output.write("\\subsubsection{%s}\n\\label{%s}\n" % (self.escape(self.title),self.key))

    def hyperlink1(self,line):
        self.output.write("\\url{%s}" % self.escape(line))

    def hyperlink2(self,url,comment):
        self.output.write("%s (\\url{%s})" % (self.escape(comment),self.escape(url)))

    def xref(self,line):
        self.output.write("%s (see page \\pageref{%s}) " % (line,self.make_key(line)))

    def bold(self,line):
        self.output.write("{\\bf %s}" % self.escape(line))

    def italic(self,line):
        self.output.write("\\emph{%s} " % self.escape(line))

    def image(self,line):
        m = re.match(r"([^ ]+) ([0-9\.]+)",line)
        if m:
            fname = m.group(1)
            width = m.group(2)
        else:
            fname = line
            width = "0.8"
        if os.access(fname,os.R_OK):
            self.output.write("\\includegraphics[width=%s\\textwidth]{%s}\n" % (width,fname))
        else:
            self.output.write("\\texttt{No such file %s}\n" % self.escape(fname))

    def imagetext(self,line):
        m = re.match(r"([^ ]+) ([0-9\.]+)",line)
        if m:
            fname = m.group(1)
            width = m.group(2)
            swidth = (1-float(width))-0.05
        else:
            fname = line
            width = "0.8"
            swidth = 0.65
        fname = fname.strip()
        frag = """\\begin{figure}[ht] 
\\begin{minipage}[b]{%s\\linewidth} 
\\centering \\includegraphics[width=\\linewidth]{%s}
\\end{minipage}
\\hspace{0.5cm}
\\begin{minipage}[b]{%s\\linewidth}
"""
        self.output.write(frag % (width,fname,swidth))

    def end_imagetext(self):
        self.end_list()
        self.output.write("\n\\end{minipage}\n\\end{figure}\n")
   
    def start_list(self):
        self.output.write("\\begin{itemize}\n")

    def list_item(self,line):
        self.output.write("\\item %s\n" % self.escape(line))

    def do_end_list(self):
        self.output.write("\\end{itemize}\n")

    def blank(self):
        self.output.write("\n\n")
        
    def centre(self,line):
        self.output.write("\\begin{center}\n%s\n\\end{center}\n" % self.escape(line))

    def pre(self,line=""):
        self.in_pre = True
        self.output.write("\\begin{verbatim}\n%s" % self.escape(line))

    def end_pre(self):
        self.in_pre = False
        self.output.write("\\end{verbatim}\n")

    def latex(self,line):
        self.output.write(line+"\n")

    def table(self,line):
        self.output.write("\\begin{tabular}") # then .latex for specific commands
    
    def col(self,line):
        self.output.write(" & %s" % self.escape(line))

    def row(self,line):
        self.output.write("\\\\\n")
    
    def end_table(self,line):
        self.output.write("\\end{tabular}\n")

    def finish(self):
        self.output.write("\\end{document}")
        self.output.close()
        if self.debian: os.chdir("build")
        os.system("pdflatex easygp.tex")

class HTMLWriter(Writer):

    def escapes(self):
        return [('&','&amp;'),('<','&lt;'),('>','&gt;'),("\t"," ")]

    def indexise(self,s): pass

    def new_html_file(self,key,title,titlefile):
        title = self.escape(title)
        if self.output:
            self.output.write("\n<hr>\n<a href=\"%s.html\">Next: %s</a>\n" % (key,title))
            self.output.write("</body></html>")
            self.output.close()
        fn = "%s.html" % key 
        self.output = self.open_output(fn)
        self.output.write("<html>\n<head><title>%s</title>\n<!--HDR-->\n</head><body>\n" % title)
        if titlefile: self.output.write("<img src=\"%s\" />\n" % titlefile)
        self.output.write("<h1>%s</h1>\n" % title)

    def hyperlink1(self,line):
        self.output.write("<a href=\"%s\">%s</a>" % (line,self.escape(line)))

    def hyperlink2(self,url,comment):
        self.output.write("<a href=\"%s\">%s</a>" % (url,self.escape(comment)))

    def xref(self,line):
        self.output.write("<a href=\"%s.html\">%s</a>" % (self.make_key(line),line))

    def bold(self,line):
        self.output.write("<b>%s</b>" % self.escape(line))

    def italic(self,line):
        self.output.write("<i>%s</i> " % self.escape(line))

    def image(self,line):
        m = re.match(r"([^ ]+) ([0-9\.]+)",line)
        if m:
            fname = m.group(1)
            #width = m.group(2)
        else:
            fname = line
            #width = "0.8"
        self.output.write("<img src=\"%s\">\n" % fname)
        if not os.access(fname,os.R_OK):
            raise IOError, "no image file %s" % fname

    def imagetext(self,line):
        m = re.match(r"([^ ]+) ([0-9\.]+)",line)
        if m:
            fname = m.group(1)
            width = m.group(2)
            swidth = (1-float(width))-0.05
        else:
            fname = line
            width = "0.8"
            swidth = 0.65
        fname = fname.strip()
        frag = "<table><tr><td><img src=\"%s\" /></td><td>"
        self.output.write(frag % fname)
        if not os.access(fname,os.R_OK):
            raise IOError, "no image file %s" % fname

    def end_imagetext(self):
        self.end_list()
        self.output.write("</td></tr></table>\n")
   
    def start_list(self):
        self.output.write("<ul>\n")

    def list_item(self,line):
        self.output.write("<li /> %s\n" % self.escape(line))

    def do_end_list(self):
        self.output.write("</ul>\n")

    def blank(self):
        self.output.write("<p/>\n")
        
    def centre(self,line):
        self.output.write("<p align=\"center\">%s</p>\n" % self.escape(line))

    def pre(self,line=""):
        self.in_pre = True
        self.output.write("<pre>%s" % self.escape(line))

    def end_pre(self):
        self.in_pre = False
        self.output.write("</pre>\n")

    def latex(self,line):
        pass

    def table(self,line):
        self.output.write("<table %s><tr><td>" % line)
    
    def col(self,line):
        self.output.write("</td><td>%s" % self.escape(line))

    def row(self,line):
        self.output.write("</td></tr><tr><td>\n")
    
    def end_table(self,line):
        self.output.write("</td></tr></table>\n")

    def finish(self):
        self.output.write("</body></html>")
        self.output.close()

class EasyGPWriter(HTMLWriter):

    def __init__(self,debian):
        super(EasyGPWriter,self).__init__(debian)
        self.toc = self.open_output("toc.txt")
        self.toctable = []
        self.index = self.open_output("index.txt.in")

    def toc_add(self,node,title,up):
        self.toc.write("%s\t%s\t%s\n" % (node,title,up))
        self.toctable.append({'node':node,'title':title,'up':up})

    def indexise(self,s):
        for word in re.split("\W+",s.lower()):
            if len(word) > 2 and not word in COMMON_WORDS:
                loc = self.subsubsection_name or self.subsection_name or self.section_name
                if loc: self.index.write("%s\t%s\n" % (word,loc))

    def section(self,line):
        super(EasyGPWriter,self).section(line)
        self.new_html_file(self.key,self.title,self.titlefile)
        self.toc_add(self.key,self.title,"root")
        self.indexise(line)

    def subsection(self,line):
        super(EasyGPWriter,self).subsection(line)
        self.new_html_file(self.key,self.title,self.titlefile)
        self.toc_add(self.key,self.title,self.section_name)
        self.indexise(line)

    def subsubsection(self,line):
        super(EasyGPWriter,self).subsubsection(line)
        self.new_html_file(self.key,self.title,self.titlefile)
        self.toc_add(self.key,self.title,self.subsection_name)
        self.indexise(line)

    def subsubsubsection(self,line):
        self.output.write("\n<h2>%s</h2>\n" % self.escape(line))
        self.indexise(line)

    def finish(self):
        super(EasyGPWriter,self).finish()
        self.index.close()
        self.toc.close()
        if self.debian:
            os.chdir("build")
        os.system("sort -u < index.txt.in > index.txt")
        os.unlink("index.txt.in")
        if self.debian:
            os.chdir("..")
            os.system("find -type d \\( \\! -path \"*.svn*\" \\) \\( \\! -path \"*build*\" \\) -exec mkdir -p build/\\{} \\;")
            os.system("find -name '*.png' \\! -path '*build*' -exec cp \\{} build/\\{} \\;")

class WebWriter(HTMLWriter):

    def __init__(self,debian):
        super(WebWriter,self).__init__(debian)
        self.toc = self.open_output("web_toc.html")
        self.toc.write("<html><head><title>Online Documentation</title></head><body>\n")

    def section(self,line):
        super(WebWriter,self).section(line)
        self.new_html_file(self.key,self.title,self.titlefile)
        self.toc.write("<p><a href=\"%s.html\">%s</a></p>\n" % (self.key,self.escape(self.title)))
                       
    def subsection(self,line):
        super(WebWriter,self).subsection(line)
        self.output.write("\n<h2>%s</h2>\n" % self.escape(line))

    def subsubsection(self,line):
        super(WebWriter,self).subsubsection(line)
        self.output.write("\n<h3>%s</h3>\n" % self.escape(line))
                       
    def subsubsubsection(self,line):
        self.output.write("\n<h4>%s</h4>\n" % self.escape(line))
                       
    def finish(self):
        super(WebWriter,self).finish()
        self.toc.write("\n</body></html>")
        self.toc.close()

if __name__=='__main__':
    debian = False

    if sys.argv[1] == '-h' or len(sys.argv) == 1:
        print """
Basicdoc v0.2

Usage: python basicdoc.py filename
"""

    else:
        engine = EasyGPWriter
        fname  = None
        for i in sys.argv[1:]:
            if i == '--debian':
                debian = True
                os.system("mkdir -p build")
            elif i == '--latex':
                engine = LatexWriter
            elif i == '--web':
                engine = WebWriter
            else:
                fname = i
        if not fname:
            sys.stderr.write("No filename provided\n")
            sys.exit(1)
        else:
            w = engine (debian)
            w.include(fname)
            w.finish()

