class User < ActiveRecord::Base
    
    before_save:downcase_email
    attr_accessor:remember_token
    validates :name, presence: true, length: {maximum: 50}
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true
    
    has_many :grades
    has_many :courses, through: :grades
    
    has_many :teaching_courses, class_name: "Course", foreign_key: :teacher_id
    #has_many :courses, through: :grades
    #has_many :teaching_courses, class_name: "Course", foreign_key: :teacher_id 
    #–这里，两句代码都指定了与课程模型的一对多关联关系，然而第一句并没有指定课程模型的名字和课程模型中的外键字段，但是Rails却能工作正常
    #这体现了Rails一个特性：convention over configuration (约定大于配置)，意思就是说只要开发人员按照一定的约定模式写代码，
    #就可以省去很多编写xml文件来指定文件路径的麻烦。这里的has_many :courses, through: :grades，Rails在解释代码的时候就会
    #默认去找有没有叫course.rb（复数变单数）的文件，而且还会去这个course模型下找有没有叫user_id的外键字段。
    #但是，根据第二句代码中的teaching_courses，Rails无法正确找到course.rb文件（这就不是仅仅是复数变单数那么简答了！），
    #所以我们需要手动指定它去找一个叫做Course类的模型和关联模型下的外键teacher_id

    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def user_remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def user_forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def user_authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def downcase_email
    self.email = email.downcase
  end


end
