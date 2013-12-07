#!/usr/bin/ruby

$output = nil
$section = nil
$subsection = nil
$subsubsection = nil
$subsubsubsection = nil
$list = false
$pre = false
                  # from the 200 commonest words in English
$common_words = ["and","but","can","will","should","the","you","was","are","they","one","his",
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


def indexise(str)
  str.downcase!
  str.split(/[^a-z]/).each do |word|
    if word.length > 2 and not $common_words.include?(word)
      loc = $subsubsection
      loc = $subsection unless loc
      loc = $section unless loc
      $index.write("%s\t%s\n" % [word,loc])
    end
  end
end

def make_key(name)
  r = name.downcase
  r.strip!
  r.delete!("\"':;,.?\\|[]{}<>()*&%$@!`~\t")
  r.gsub!(' ','-')
  return r
end

def parse_name(name)
  if name =~ /([a-z\/]+\.(png|jpg|jpeg)) (.+)/
    title = $3
    file = $1
  else
    file = nil
    title = name
  end
  return [title,file]
end

def new_html_file(key,title,file)
  if $output
    $output.write("<!--FTR--></body></html>")
    $output.close
  end
  title = esc(title)
  if $debian
    $output = File.new("build/"+key+".html",'w')
  else
    $output = File.new(key+".html",'w')
  end
  $output.write("<html><head><title>%s</title><!--HDR--></head><body>\n" % title)
  if file
    $output.write("<img src=\"%s\" />\n" % file)
  end
  $output.write("<h2>%s</h2>\n" % title)
  indexise(title)
end

def esc(str)
  s2 = str.gsub('&','&amp;')
  s2 = s2.gsub('<','&lt;')
  s2 = s2.gsub('>','&gt;')
  return s2.gsub("\t"," ")
end


def latex_esc(str)
  s2 = str.gsub('\\', '\\\\')
  s2.gsub!('/','\\slash ')
  s2.gsub!('$', '\\$')
  s2.gsub!('%', '\\%')
  s2.gsub!('&', '\\&')
  s2.gsub!('<', '$<$')
  s2.gsub!('>', "$>$")
  return s2.gsub('_', '\\textunderscore ')
end

def process_file(fd)
  fd.each_line  do |line|
    case line
    when /^\.include (.*)/
      begin
        $latex.write(latex_esc("\n\n\\texttt{[File %s]}\n\n" % $1))
        process_file(File.new($1))
      rescue
	$latex.write(latex_esc("\n\n\\textt{[No such file %s]}\n\n" % $1))
        $output.write("<p><tt>No such file %s</tt></p>" % $1)
$stderr.write("no such file %s\n" % $1)
      end
    when /^\.section (.*)/
      title, file = parse_name($1)
      key = make_key(title)
      $section = key
      $subsection = nil
      $subsubsection = nil
      $toc.write("%s\t%s\troot\n" % [key,title])
      $latex.write("\\chapter{%s}\n\\label{%s}\n" % [latex_esc(title),key])
      new_html_file(key,title,file)
    when /^\.subsection (.*)/
      title, file = parse_name($1)
      key = make_key(title)
      $subsection = key 
      $subsubsection = nil
      $toc.write("%s\t%s\t%s\n" % [key,title,$section])
      $latex.write("\\section{%s}\n\\label{%s}\n" % [latex_esc(title),key])
      new_html_file(key,title,file)
    when /^\.subsubsection (.*)/
      title, file = parse_name($1)
      key = make_key(title)
      $subsubsection = key
      $toc.write("%s\t%s\t%s\n" % [key,title,$subsection])
      $latex.write("\\subsection{%s}\n\\label{%s}\n" % [latex_esc(title),key])
      new_html_file(key,title,file)
    when /^\.paragraph (.*)/,/^\.subsubsubsection (.*)/
      $output.write("\n<h3>%s</h3>\n" % esc($1))
      $latex.write("\\subsubsection{%s}\n" % latex_esc($1))
      indexise($1)
    when /^\.link ([^ ]+) ?(.*)/
      if $2.nil? or $2 == ''
        $output.write("<a href=\"%s\">%s</a>" % [$1,$1])
        $latex.write("{\\tt %s}" % latex_esc($1))
      else
        $latex.write("%s ({\\tt %s})" % [latex_esc($2),latex_esc($1)])
        $output.write("<a href=\"%s\">%s</a>" % [$1,$2])
      end
    when /^\.xref (.*)/
      $output.write("<a href=\"%s.html\">%s</a>" % [make_key($1),$1])
      $latex.write("%s (see page \\pageref{%s})" % [$1,make_key($1)])
    when /^\.bold (.*)/
      $output.write("<b>%s</b> " % esc($1))
      $latex.write("{\\bf %s} " % latex_esc($1))
      indexise($1)
    when /^\.italic (.*)/
      $output.write("<i>%s</i> " % esc($1))
      $latex.write("\\emph{%s} " % latex_esc($1))
      indexise($1)
    when /^\.image ([^ ]+) ?(.*)/
      fname = $1.strip
      $output.write("<img src=\"%s\" />" % fname)
      if File.exist?(fname)
	if $2.nil? or $2 == ''
          width = 0.8
        else
          width = $2
        end 
        $latex.write("\\includegraphics[width=%s\\textwidth]{%s}\n" % [width,fname])
      else
        $stderr.write("no such file %s\n" % fname)
        $latex.write("\n\n{\\tt File %s does not exist}\n\n" % latex_esc(fname))
      end 
    when /^\.item(.*)/
      unless $list
        $output.write("\n<ul>\n")
        $latex.write("\\begin{itemize}")
        $list = true
      end
      $output.write("<li>%s" % esc($1))
      $latex.write("\n\\item %s" % latex_esc($1))
      indexise($1)
    when /^\.imagetext ([^ ]+) ?(.*)/
      fname = $1.strip
      if $2.nil? or $2 == ''
        width = "0.3"
        swidth = "0.65"
      else
        width = $2
	swidth = (1-$2.to_f)-0.05
      end
      $output.write("<table><tr><td><img src=\"%s\" /></td><td>" % fname)
      if File.exist?(fname)
        fname = "\\includegraphics[width=\\linewidth]{%s}" % fname
      else
        $stderr.write("File does not exist %s\n" % fname)
        fname = "{\\tt File %s does not exist}" % latex_esc(fname)
      end
      frag = <<EOF
\\begin{figure}[ht] 
\\begin{minipage}[b]{%s\\linewidth} 
\\centering %s
\\end{minipage}
\\hspace{0.5cm}
\\begin{minipage}[b]{%s\\linewidth}
EOF
        $latex.write(frag % [width,fname,swidth])
    when /^\.end imagetext/
      if $list
        $output.write("</ul>")
        $latex.write("\n\\end{itemize}\n")
        $list = false
      end
      $output.write("</td></tr></table>")
      $latex.write("\n\\end{minipage}\n\\end{figure}\n")
    when '',"\n"
      if $list 
        $output.write("\n</ul>\n")
        $latex.write("\\end{itemize}\n")
        $list = false
      else
        $output.write("<p/>\n")
        $latex.write("\n\n")
      end
    when /\.centre (.*)/
      $output.write("<p align=\"center\">%s</p>" % esc($1))
      $latex.write("\\begin{center}\n%s\n\\end{center}\n" % latex_esc($1))
      indexise($1)
    when /\.pre$/
      $output.write("<pre>\n")
      $latex.write("\\begin{verbatim}\n")
      $pre = true
    when /\.end pre/
      $output.write("\n</pre>\n")
      $latex.write("\\end{verbatim}\n")
      $pre = false
    when /\.latex (.*)/
      $latex.write($1+"\n")
    when /\.table(.*)/
      $output.write("<table%s><tr><td>" % $1)
      $latex.write("\\begin{tabular}") # then .latex for specific commands
    when /\.col/
      $output.write("</td><td>")
      $latex.write(" & ")
    when /\.row/
      $output.write("</td></tr><tr><td>\n")
      $latex.write("\\\\\n")
    when /\.end table/
      $output.write("</td></tr></table>\n")
      $latex.write("\\end{tabular}\n"
    else
      if $pre
        $latex.write(line) 
        $output.write(line)
      else
        $latex.write(latex_esc(line))
        $output.write(esc(line))
      end
      indexise(line)
    end
  end
  fd.close
end

if ARGV[0] == "-h" or ARGV.length == 0
  STDOUT.write(<<EOF
Basicdoc v0.1

Usage: ruby basicdoc.rb filename
EOF
)
else
  fd = File.new(ARGV[0])
  $latex = File.new('easygp.tex','w')
  $latex.write File.open("intro.tex") {|f| f.read }
  if ARGV[1] == '--debian'
    system 'mkdir -p build'
    $debian = true
    $index = File.new('build/index.txt.in','w')
    $toc = File.new('build/toc.txt','w')
  else
    $debian = false
    $index = File.new('index.txt.in','w')
    $toc = File.new('toc.txt','w')
  end

  process_file(fd)
  $output.write("\n</body></html>\n")
  $output.close
  $toc.close
  $index.close
  Dir.chdir("build") if $debian
  system "sort -u < index.txt.in > index.txt"
  system "rm index.txt.in"
  Dir.chdir("..") if $debian
  system "find -type d \\( \\! -path \"*.svn*\" \\) \\( \\! -path \"*build*\" \\) -exec mkdir -p build/\\{} \\;"
  system "find -name *.png \\! -path '*build*' -exec cp \\{} build/\\{} \\;"
  $latex.write File.open("gpl-3.0.tex") {|f| f.read}
  $latex.write("\n\\end{document}\n")
  $latex.close
  #system "pdflatex easygp.tex"
end
