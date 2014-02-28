class Retrospective < ActiveRecord::Base
  belongs_to :dojo

  def empty?
    self.challenge.blank? && self.improvement_points.blank? && positive_points.blank?
  end

  def not_empty?
    !empty?
  end
end
