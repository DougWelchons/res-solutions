FieldInterview.destroy_all
FieldInterviewQuestion.destroy_all
Interview.destroy_all
InterviewQuestion.destroy_all
AdditionalDocument.destroy_all
RelatedPart.destroy_all
Part.destroy_all
SubSection.destroy_all
Section.destroy_all
Report.destroy_all
User.destroy_all

Builder.build_report(name: "Report 1", company: "Sample Company")
Builder.build_report(name: "Report 2", company: "Sample Company", status: 5)
Builder.build_report(name: "Report 3", company: "Sample Company")

@user1 = User.create!(name: "Name 1", email: "test1@sample.com", password: "Password1", password_confirmation: "Password1")
@user2 = User.create!(name: "Name 2", email: "test2@sample.com", password: "Password2", password_confirmation: "Password2")
@user3 = User.create!(name: "Name 3", email: "test3@sample.com", password: "Password3", password_confirmation: "Password3")
@user4 = User.create!(name: "Name 4", email: "test4@sample.com", password: "Th1$Te$t1sG0od", password_confirmation: "Th1$Te$t1sG0od")
