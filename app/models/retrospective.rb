class Retrospective < ActiveRecord::Base
  belongs_to :dojo
  attr_accessible :challenge, :improvement_points, :positive_points

  def empty?
    self.challenge.blank? && self.improvement_points.blank? && positive_points.blank?
  end

  def not_empty?
    !empty?
  end
end
