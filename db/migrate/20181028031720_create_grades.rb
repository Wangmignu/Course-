class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      
      t.belongs_to:course,index:true
      t.belongs_to:user,index:true 
      t.integer:grade
      
#这里的t.belongs_to: :course 就等于 t.integer :course_id，记录了课程表中课程的id。如此表示的意图在于更加清晰地表达模型之间的从属关系：

#一个课程拥有多个成绩，一个成绩只属于一个课程；一个学生拥有多个成绩，一个成绩只属于一个学生；学生和课程两个属性能唯一确定成绩

      t.timestamps null: false
    end
  end
end
