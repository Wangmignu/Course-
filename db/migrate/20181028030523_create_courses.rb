class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      
      t.string:name
      t.string:course_code
      t.string:course_type
      t.string:teaching_type
      t.string:exam_type
      t.string:credit
      t.integer:limit_num
      t.integer:student_num,default:0
      t.string:class_room
      t.string:course_time
      t.string:course_week
      t.belongs_to:teacher  #表达模型之间的从属关系
      #一个老师上多门课，每一门属于一个老师。这里老师和课程是也是一对多的关系（为了简化，就不再设计为多对多的关联关系了）
      #t.belongs_to :teacher，就已经将用户（老师）的id作为外键储存在课程模型的数据表中，目的就是要实现用户（老师）与课程模型的一对多关系
      #即在课程模型的数据表中查找某个用户（老师）的id，就能将取出与这个id相关的所有课程的数据。


      t.timestamps null: false
    end
  end
end
