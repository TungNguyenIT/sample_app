module ApplicationHelper
  def full_title page_title = ""
    base_title = t "static_pages.title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
