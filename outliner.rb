module Outliner

  attr_accessor :output
  attr_accessor :depth

  def outline(desc, *args, &block)
    @output = ""
    @depth = 0
    @output = <<-OUTLINE
      <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
                          "http://www.w3.org/TR/html4/loose.dtd">
      <html>
      <head>
      <title>Outline</title>
      <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
      <script src="https://github.com/jzaefferer/jquery-treeview/raw/master/jquery.treeview.js" type="text/javascript" ></script>
      <script src="https://github.com/carhartl/jquery-cookie/raw/master/jquery.cookie.js" type="text/javascript" ></script>
      <link rel="stylesheet" href="http://jquery.bassistance.de/treeview/demo/screen.css" type="text/css" />
      <link rel="stylesheet" href="http://jquery.bassistance.de/treeview/jquery.treeview.css" type="text/css" />
      <script type='text/javascript'>
      $(document).ready(function() {
        $(".outline").treeview({
          collapsed: true,
          //persist: "cookie",
          control: "#outlinecontrol"
        });
      });
      </script>
    
      <style type="text/css">
          ul li{list-style-position: inside;}
          ul.o2{list-style-type: upper-roman;}
          ul.o3{list-style-type: upper-alpha; }
          ul.o4{list-style-type: decimal; }
          ul.o5{list-style-type: lower-alpha; }
          ul.o6{list-style-type: disc; }
          ul.o7{list-style-type: square; }
          ul.o8{list-style-type: circle; }
      </style>
      </head>
      <body>
        <div id="outlinecontrol">
          <a title="Collapse the entire tree below" href="#"><img src="../images/minus.gif" /> Collapse All</a>
          <a title="Expand the entire tree below" href="#"><img src="../images/plus.gif" /> Expand All</a>
          <a title="Toggle the tree below, opening closed branches, closing open branches" href="#">Toggle All</a>
        </div>
    OUTLINE
    
    _list(:outline) do
      _line(desc, &block) if block_given?
    end
    
    puts output + <<-FOOT
      </body></html>
    FOOT
  end
  
  def _list(kind)
    @depth += 1
    @output += "<ul class='o#{depth} #{kind}'>"
    yield if block_given?
    @output += "</ul>\n"
    @depth -= 1
  end
  
  def _line(desc, &block)
    @output += "<li><span class='o#{depth} #{__method__}'>#{desc}</span>"
    _list(__method__, &block) if block_given?
    @output += "</li>\n"
  end
  alias :o :_line
  alias :b :_line
  alias :t :_line
  alias :p :_line
  alias :s :_line
  alias :todo :_line
  
end