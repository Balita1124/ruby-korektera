#!/usr/bin/env ruby
# coding: utf-8
module ApplicationHelper

  def full_title(page_title='')
    base_title = "ICA"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def prenom(id)
    resultat = User.find(id)
    resultat.prenom
  end

  def project_name(id)
    resultat = Project.find(id)
    resultat.name
  end

  def check_pourcentage(project_id)
    pourcentage = pourcentage_corretion_par_project(project_id)
    if pourcentage < 25
      return "display:block;height:100%;width:#{pourcentage}%;background-color:red"
    elsif pourcentage > 25 and pourcentage < 75
      return "display:block;height:100%;width:#{pourcentage}%;background-color:orange"
    elsif pourcentage > 75
      return "display:block;height:100%;width:#{pourcentage}%;background-color:green"
    end
  end

  def mcm?
    return true if current_user.groupe == 1
  else
    false
  end

  def auteur?
    return true if current_user.groupe == 2
  else
    false
  end

  def nb_corretions(project_id)
    if auteur?
      corrections = Correction.where("user_id = ? and project_id = ?", current_user.id, project_id).count
    elsif mcm?
      corrections = Correction.where("user_correcteur_id = ? and project_id = ?", current_user.id, project_id).count
    end
  end

  def pourcentage_corretion_par_project(project_id)
    if auteur?
      corrections_mine = Correction.where("user_id = ? and project_id = ?", current_user.id, project_id).count
      correction_all = nb_tous_correction_par_projet(project_id)
      return ((corrections_mine * 1.0) / correction_all) * 100
    elsif mcm?
      corrections_mine = Correction.where("user_correcteur_id = ? and project_id = ?", current_user.id, project_id).count
      correction_all = nb_tous_correction_par_projet(project_id)
      return (((corrections_mine * 1.0) / correction_all) * 100).round(2)
    end
  end

  def nb_tous_corrections
    correction_all = Correction.all.count
  end

  def nb_tous_correction_par_projet(project_id)
    if auteur?
      correction_all = Correction.where("project_id = ?", project_id).count
    elsif mcm?
      correction_all = Correction.where("project_id = ?", project_id).count
    end
  end

  def nb_tous_mes_corrections
    if auteur?
      corrections_mine = Correction.where("user_id = ?", current_user.id).count
    elsif mcm?
      corrections_mine = Correction.where("user_correcteur_id = ?", current_user.id).count
    end
  end

  def pourcentage_total
    if auteur?
      corrections_mine = Correction.where("user_id = ?", current_user.id).count
      correction_all = nb_tous_corrections
      return ((corrections_mine * 1.0) / correction_all) * 100
    elsif mcm?
      corrections_mine = Correction.where("user_correcteur_id = ?", current_user.id).count
      correction_all = nb_tous_corrections
      #abort ((corrections_mine / correction_all)).inspect
      return (((corrections_mine * 1.0) / correction_all) * 100).round(2)
    end
  end

  def groupe(id)
    resultat = User.find(id)
    groupe = resultat.groupe
    if groupe == 1
      return "mcm"
    elsif groupe == 2
      return "auteur"
    elsif groupe == 0
      return "admin"
    else
      return nil
    end
  end

  def actionName(index)
    action = {0 => "Modification", 1 => "Suppression", 2 => "Insertion", 3 => "Remplacement", 4 => "Commentaire", }
    return action[index]
  end

  def etatName(index)
    etat = {0 => "En attente", 1 => "Corrigé", 2 => "Verifier"}
    return etat[index]
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def check_active(controller, action)
    return "activated" if (controller?(controller) && action?(action))
  else
    nil
  end

  def check_action(correction, action)
    if correction.nil?
      return nil
    else
      if correction.action==action
        return "selected=\"selected\""
      end
    end
  end

  def check_selected_action(correction, etat)
    return "selected" if (!correction.nil? and correction.etat == etat)
  else
    nil
  end


end



