module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - OHEシステム"
    else
      "OHEシステム"
    end
  end
end
