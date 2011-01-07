require 'outliner'
include Outliner

outline "This is my outline" do
  s "This is a section" do
    p "This is a paragraph" do
      t "This is a topic in the paragraph"  
    end
    p "This is a paragraph without topics"
  end
  s "This is another section"
  p "This is a paragraph, but it (mostly) doesn't matter the method called."
  todo "I can use this too."
end