class Report < ApplicationRecord
# after_create :build_report_sections

  has_many :sections
  has_many :sub_sections, through: :sections
  has_many :parts, through: :sub_sections

  validates :name, presence: true, uniqueness:true
  validates :company, presence: true

  enum status: [:prep, :kick_off, :document_review, :field_review, :reporting, :closed]

  # def build_report_sections
  #   structure = [
  #     {
  #       section_name: "P1 Ethics",
  #       sub_sections: [
  #                       {
  #                         section_number: "1.1",
  #                         section_name: "LEGAL COMPLIANCE",
  #                         parts:
  #                               {
  #                                 100 => 8,
  #                                 101 => 0,
  #                                 102 => 0
  #                               }
  #                       },
  #                       {
  #                         section_number: "1.2",
  #                         section_name: "FINANCIAL DISCLOSURE",
  #                         parts:
  #                               {
  #                                 100 => 6,
  #                                 101 => 0,
  #                                 102 => 0
  #                               }
  #                         },
  #                       {
  #                         section_number: "1.3",
  #                         section_name: "BRIBERY, CORRUPTION, MONEY LAUNDERING & FINANCING OF TERRORISM",
  #                         parts: {
  #                           100 => 4,
  #                           101 => 0,
  #                           102 => 0}},
  #                       {
  #                         section_number: "1.4",
  #                         section_name: "MANAGEMENT SYSTEMS",
  #                         parts: {
  #                           100 => 25,
  #                           101 => 0,
  #                           102 => 1}},
  #                       {
  #                         section_number: "1.5",
  #                         section_name: "CONTRACTORS",
  #                         parts: {
  #                           100 => 3, 101 => 0, 102 => 0}},
  #                       {
  #                         section_number: "1.6",
  #                         section_name: "TRANSPARENCY & DISCLOSURE",
  #                         parts: {
  #                           100 => 7,
  #                           101 => 3,
  #                           102 => 2}}]},
  #     {section_name: "P2 Social", sub_sections: [
  #         {section_number: "2.1", section_name: "HUMAN RIGHTS", parts: {100 => 9, 101 => 0, 102 => 0}},
  #         {section_number: "2.2", section_name: "FAIR, INCLUSIVE ENGAGEMENT & GOOD FAITH CONSULTATION", parts: {100 => 20, 101 => 0, 102 => 1}},
  #         {section_number: "2.3", section_name: "HUMAN RIGHTS & SECURITY PERSONNEL", parts: {100 => 20, 101 => 2, 102 => 0}},
  #         {section_number: "2.4", section_name: "LAND RIGHTS", parts: {100 => 8, 101 => 0, 102 => 0}},
  #         {section_number: "2.5", section_name: "RESETTLEMENT", parts: {100 => 12, 101 => 0, 102 =>0}},
  #         {section_number: "2.6", section_name: "UNCONTROLLED SETTLEMENTS", parts: {100 => 4, 101 => 0, 102 => 0}},
  #         {section_number: "2.7", section_name: "COMMUNITY HEALTH & SAFETY", parts: {100 => 8, 101 => 0, 102 => 8}},
  #         {section_number: "2.8", section_name: "SUSTAINABLE COMMUNITY INVESTMENT", parts: {100 => 19, 101 => 0, 102 => 1}},
  #         {section_number: "2.9", section_name: "CULTURAL HERITAGE", parts: {100 => 3, 101 => 0, 102 => 0}},
  #         {section_number: "2.10", section_name: "GRIEVANCE MECHANISM", parts: {100 => 9, 101 => 0, 102 => 1}}]},
  #     {section_name: "P3 Indigenous", sub_sections: [
  #         {section_number: "3.1", section_name: "FREE, PRIOR & INFORMED CONSENT (FPIC)", parts: {100 => 6, 101 => 0, 102 => 3}},
  #         {section_number: "3.2", section_name: "ENGAGEMENT & PARTICIPATION", parts: {100 => 13, 101 => 0, 102 => 0}},
  #         {section_number: "3.3", section_name: "CULTURAL IMPACTS", parts: {100 => 4, 101 => 0, 102 => 0}},
  #         {section_number: "3.4", section_name: "USE OF TRADITIONAL NATURAL RESOURCES", parts: {100 => 3, 101 => 0, 102 => 0}},
  #         {section_number: "3.5", section_name: "CULTURE-BASED INTELLIGENCE & TRADITIONAL KNOWLEDGE", parts: {100 => 7, 101 => 0, 102 => 0}},
  #         {section_number: "3.6", section_name: "VOLUNTARY ISOLATION", parts: {100 => 4, 101 => 0, 102 => 0}}]},
  #     {section_name: "P4 Labor", sub_sections: [
  #         {section_number: "4.1", section_name: "LABOR & WORKING CONDITIONS", parts: {100 => 5, 101 => 0, 102 => 0}},
  #         {section_number: "4.2", section_name: "CHILD LABOR", parts: {100 => 6, 101 => 0, 102 => 0}},
  #         {section_number: "4.3", section_name: "FORCED LABOR", parts: {100 => 4, 101 => 0, 102 => 0}},
  #         {section_number: "4.4", section_name: "FREEDOM OF ASSOCIATION & COLLECTIVE BARGAINING", parts: {100 => 4, 101 => 0, 102 => 0}},
  #         {section_number: "4.5", section_name: "EQUAL OPPORTUNITIES & TREATMENT", parts: {100 => 8, 101 => 0, 102 => 0}},
  #         {section_number: "4.6", section_name: "WORKING HOURS & LEAVE", parts: {100 => 4, 101 => 0, 102 => 0}},
  #         {section_number: "4.7", section_name: "REMUNERATION", parts: {100 => 11, 101 => 0, 102 => 0}},
  #         {section_number: "4.8", section_name: "WORKPLACE GRIEVANCES", parts: {100 => 5, 101 => 0, 102 => 0}},
  #         {section_number: "4.9", section_name: "OCCUPATIONAL HEALTH & SAFETY", parts: {100 => 22, 101 => 0, 102 => 6}},
  #         {section_number: "4.10", section_name: "EMERGENCY PREPAREDNESS & RESPONSE PLANNING", parts: {100 => 9, 101 => 0, 102 => 1}}]},
  #     {section_name: "P5 Enviroment", sub_sections: [
  #         {section_number: "5.1", section_name: "ENVIRONMENTAL MANAGEMENT & MITIGATION", parts: {100 => 7, 101 => 0, 102 => 0}},
  #         {section_number: "5.2", section_name: "EMERGENCY PREPAREDNESS & RESPONSE PLANNING", parts: {100 => 7, 101 => 5, 102 => 1}},
  #         {section_number: "5.3", section_name: "ENERGY EFFICIENCY", parts: {100 => 3, 101 => 0, 102 => 0}},
  #         {section_number: "5.4", section_name: "WASTE PRODUCTION & MANAGEMENT", parts: {100 => 8, 101 => 1, 102 => 2}},
  #         {section_number: "5.5", section_name: "REMEDIATION OF ENVIRONMENTAL LIABILITIES", parts: {100 => 5, 101 => 0, 102 => 0}},
  #         {section_number: "5.6", section_name: "CLOSURE & RESTORATION", parts: {100 => 5, 101 => 0, 102 => 0}},
  #         {section_number: "5.7", section_name: "GREENHOUSE GAS EMISSIONS", parts: {100 => 11, 101 => 1, 102 => 6}},
  #         {section_number: "5.8", section_name: "OZONE DEPLETION", parts: {100 => 4, 101 => 0, 102 => 0}},
  #         {section_number: "5.9", section_name: "BIODIVERSITY & ECOLOGY", parts: {100 => 13, 101 => 0, 102 => 0}},
  #         {section_number: "5.10", section_name: "AIR", parts: {100 => 3, 101 => 6, 102 => 3}},
  #         {section_number: "5.11", section_name: "WATER", parts: {100 => 18, 101 => 3, 102 => 28}},
  #         {section_number: "5.12", section_name: "LAND", parts: {100 => 6, 101 => 0, 102 => 6}},
  #         {section_number: "5.13", section_name: "LAND RESTORATION", parts: {100 => 12, 101 => 0, 102 => 0}},
  #         {section_number: "5.14", section_name: "VISUAL AND AMBIENT IMPACTS", parts: {100 => 18, 101 => 0, 102 => 0}}]}]
  #
  #   structure.each do |section|
  #     Section.build(section)
  #   end
  # end
end
