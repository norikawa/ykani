module NorikawaStandard
  extend self

  def hook(page_data)
    title = page_data["TITLE"]
    id = page_data["ID"]
    stylesheet = page_data["STYLE"]
    bg_img = page_data["BG-IMG"]
    content = page_data["CONTENT"]
    navbar = build_navbar(page_data["UP-NODE"], parse_list(page_data["DOWN-NODES"]), page_data["UP-NAME"], parse_list(page_data["DOWN-NAMES"]))
    accounts = build_accounts(Ykani::Arktanyl.new(("#{ARK_LOCATION}/accounts.ark")).data)
    copyright = ""
    return ECR.render("forms/norikawa/NorikawaStandard.ecr")
  end
  
  private def navbar_template(page, name)
    return "<li><a href='#{Ykani.config["server"]["url"]}#{page}'><div class='navbar__item'>#{name}</div></a></li>"
  end
    
  private def build_navbar(up_node, down_nodes, up_name, down_names)
    product = ""
    if up_node != ""
      product = product + navbar_template(up_node, up_name)
    end
    if down_nodes != [""]
      down_nodes.each do |node|
        index = down_nodes.index(node)
        node = node.strip
        if index
          product = product + navbar_template(node, down_names[index])
          next
        end
      end
    end
    return product
  end

  private def accounts_template(url, img)
    return "<a href='#{url}'><img class='account-image' src='#{img}'/></a>"
  end

  private def build_accounts(accounts)
    product = ""
    accounts.each do |account|
      product = product + accounts_template(account["URL"], account["IMG"])
    end
    return product
  end

  private def parse_list(list)
    product = [] of String
    list = list.strip
    split_list = list.split(",")
    split_list.each do |item|
      item.strip
      product << item
    end
    return product
  end

end

