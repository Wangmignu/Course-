class Course < ActiveRecord::Base
    
    has_many :grades
    has_many :users, through: :grades
    #这里，课程模型通过has_many方法描述与其他模型的一对多的关联关系。through 参数描述了：此一对多关系是通过成绩模型才关联到用户模型的。
    belongs_to:teacher,class_name:"User"
    #belongs_to 方法描述了与其他模型的多对一的关联关系，class_name 指定了用户模型的类名，这样Rails才能正确找到关联的用户模型。
    validates :name, :course_type, :course_time, :course_week,
            :class_room, :credit, :teaching_type, :exam_type, presence: true, length: {maximum: 50}

    #validates 方法指定了对模型下的字段的验证，这里一共验证了:name, :course_type, :course_time, :course_week,
    #:class_room, :credit, :teaching_type, :exam_type 8个字段，验证要求是 presence: true, length: {maximum: 50}，
    #表示各个字段要存在（不为空）而且最大长度不能超过50个字符。验证会在每次保存课程数据的时候执行

end
