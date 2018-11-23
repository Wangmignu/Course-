class CoursesController < ApplicationController#表示类继承
    
     def new#新建课程
    @course=Course.new
     end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by(id: params[:id])#params[:id]表示Rails从URL里读取的当前需要编辑课程的id，例如http://whatever.com/course/17中的17
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  def index
    @course=Course.all#负责对所有的对象进行展示，逻辑为：在Course类中调用all方法返回所有课程对象，然后交给视图
  end

  private

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week)
  end

#params方法能返回URL请求包含的所有数据，
#而flash作为一个Hash表（哈希表），起到了重定向后提示语的作用，能在用户操作后，告诉用户的操作的结果（成功、失败或者需要登录等）

#create，update，destroy一般不直接渲染页面（有时也会），只会修改数据库中保存的用户数据
end
