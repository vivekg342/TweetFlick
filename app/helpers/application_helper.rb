module ApplicationHelper
  def title(page_title, options={})
  content_for(:title, page_title.to_s)
  return content_tag(:h1, page_title, options)
end

def ogimage(image)
   content_for(:ogimage, image.to_s)
end
def ogtitle(otitle)
    content_for(:ogtitle, otitle.to_s)
end

def bigger(image)
image.gsub!(/_normal\.(?=png|gif|jpg|jpeg|tiff|TIFF|bmp|JPG|JPEG|GIF|PNG|BMP +\z)/,'_bigger.\2')  
end
end
