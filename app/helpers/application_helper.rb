# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sort_td_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end

  def sort_link_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => {:action => 'index', :params => params.merge({:sort => key, :page => nil})},
        :method => :get
    }
    html_options = {
      :title => "Sort by this field",
      :href => url_for(:action => 'index', :params => params.merge({:sort => key, :page => nil}))
    }
    link_to(text, options, html_options)
  end


  def parse_xml_package(xml, root="")
    #puts xml
    packages = Array.new
    doc = REXML::Document.new(xml)
    doc.elements.each("#{root}tpkg/") do |ele|
      package = Hash.new
      package["name"] = ele.elements["name"].text
      package["version"] = ele.elements["version"].text
      package["os"] = ele.elements["operatingsystem"].text if ele.elements["operatingsystem"]
      package["arch"] = ele.elements["architecture"].text if ele.elements["architecture"]
      package["maintainer"] = ele.elements["maintainer"].text
      package["description"] = ele.elements["description"].text if ele.elements["description"]
      package["package_version"] = ele.elements["package_version"].text if ele.elements["package_version"]
      package["filename"] = ele.attributes["filename"]
      packages << package
    end
    return packages
  end
end
