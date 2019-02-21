#!/usr/bin/env ruby
# coding: utf-8
module UtilissateurHelper
  def correction_title
    if mcm?
      return "Corrections effectuées"
    elsif auteur?
      return "Corrections ajoutées"
    else
      return "haha"
    end
  end

  def check_role_selected(groupe,value)
    return "selected" if groupe == value
  end
end